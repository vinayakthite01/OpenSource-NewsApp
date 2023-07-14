//
//  DirectURLRouter.swift
//  NewsApp
//
//  Created by Vinayak Thite on 22/08/22.
//

import Foundation

import UIKit

// MARK: - API Request DirectURLRouter -
final class DirectURLRouter<EndPoint: DirectURLEndpointType> {
    private var task: URLSessionTask?
    
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
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

        guard let url = URL(string: route.urlPath) else {
            completion(.failure(.somethingWentWrong))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = route.httpMethod.rawValue

        self.task = decodingTask(with: urlRequest, decodingType: T.self) { (json, error) in

            DispatchQueue.main.async {
                if error != nil {
                    completion(.failure(.responseUnsuccessful(description: error!.description)))
                    return
                }
                guard let json = json else {
                    completion(.failure(.somethingWentWrong))
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
            
            } catch let error {
                Logger.log(error.localizedDescription)
                completion(nil, .jsonDecodingFailure)
            }
        }
        return task
    }
}
