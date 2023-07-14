//
//  Router.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation


// MARK: - API Request Router -
final class Router<EndPoint: EndPointType> {
    private var task: URLSessionTask?
    
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    /// `initializer`
    init() {
    }
    
    /// Build API Request
    /// - Parameters:
    ///   - route: End Point
    ///   - decode: T (custom model class) as Decodable
    ///   - completion: data, response & error
    func request<T: Decodable>(_ route: EndPoint,
                               decode: @escaping (Decodable) -> T?,
                               completion: @escaping (Result<T, APIError>) -> Void) {

        guard NetworkStateCheck.isConnected else {
            completion(.failure(.unreachable))
            return
        }
        
        var components = URLComponents()
        components.scheme = route.scheme
        components.host = route.baseURL
        components.path = route.path
        components.queryItems = route.parameters
        
        Logger.log("components:\(components)")
        guard let url = components.url else {
            completion(.failure(.somethingWentWrong))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = route.httpMethod.rawValue
        urlRequest.httpBody = route.data

        var headers = route.headers ?? []
        
        headers.forEach { urlRequest.addValue($0.header.value, forHTTPHeaderField: $0.header.field) }
        
        Logger.log(curl: urlRequest)

        self.task = decodingTask(with: urlRequest, decodingType: T.self) { [weak self] (json, error) in

            DispatchQueue.main.async {
                if error != nil && error == APIError.unauthorized {
                    
                    return
                }
                guard let json = json else {
                    completion(error != nil ?
                               .failure(.responseUnsuccessful(description: error!.description)) :
                               .failure(.somethingWentWrong))
                    return
                }
                guard let value = decode(json) else {
                    completion(.failure(.jsonDecodingFailure))
                    return
                }
                completion(.success(value))
            }
        }

        self.task?.resume()
    }

    /// Request cancellation
    func cancel() {
        self.task?.cancel()
    }
    
    // MARK: - Parsing response
    private func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
       
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed(description: error?.localizedDescription ?? "## Request Fail"))
                return
            }
                        
            if httpResponse.statusCode == 401 {
                completion(nil, .unauthorized)
                return
            }
            
            if httpResponse.statusCode == 204 ||
                httpResponse.statusCode == 202 {
                completion(EmptyData(), nil)
                return
            }
            
            guard let data = data else {
                completion(nil, .somethingWentWrong)
                return
            }
           
            Logger.logResponse(data, url: request.url!, code: httpResponse.statusCode)
            
            var errorData: APIErrorResponseModel?
            do {
                errorData = try JSONDecoder().decode(APIErrorResponseModel.self, from: data)
            } catch {}
            
            if errorData != nil {
                completion(nil, .custom(model: errorData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(.iso8601Full)
                                
                #if DEBUG
                // swiftlint:disable force_try
                /// Using force !try for debugging. This way Xcode log shows if parsing failed due to data type mismatch.
                let genericModel = try! decoder.decode(decodingType, from: data)
                // swiftlint:enable force_try

                #else
                let genericModel = try decoder.decode(decodingType, from: data)
                #endif
                
                completion(genericModel, nil)
            
            } 
        }
        return task
    }
}
