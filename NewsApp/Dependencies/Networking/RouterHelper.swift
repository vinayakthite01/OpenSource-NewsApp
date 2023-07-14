//
//  RouterHelper.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation

/// HTTP Headers
enum HTTPHeader {
    case content(String)
    case accept(String)
    case auth(String)
    case custom(String, String)
    
    var header: (field: String, value: String) {
        switch self {
        case .content(let value): return (field: "Content-Type", value: value)
        case .accept(let value): return (field: "Accept", value: value)
        case .auth(let value): return (field: "Authorization", value: "Bearer " + value)
        case .custom(let key, let value): return (field: key, value: value)
        }
    }
}

/// Request Method type
enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

/// EndPointType protocol
protocol EndPointType {
    /// scheme
    var scheme: String { get }
    
    /// base URL
    var baseURL: String { get }
    
    /// request path
    var path: String { get }
    
    /// request Method
    var httpMethod: HTTPMethod { get }
    
    /// API Params
    var parameters: [URLQueryItem]? { get }
    
    /// API header
    var headers: [HTTPHeader]? { get }
    
    /// Data
    var data: Data? { get }
}

/// API errors enum
enum APIError: Error, Equatable {
    case unauthorized
    case unreachable
    case somethingWentWrong
    case jsonDecodingFailure
    case responseUnsuccessful(description: String)
    case requestFailed(description: String)
    case custom(model: APIErrorResponseModel?)
    
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        lhs.description == rhs.description
    }
}

/// API errors enum entension
extension APIError: CustomStringConvertible {
    var customDescription: String {
        switch self {
        case .unauthorized: return L10n.Error.unauthorized
        case .unreachable: return L10n.Error.noInternet
        case .somethingWentWrong: return L10n.Error.somethingWentWrong
        case .jsonDecodingFailure: return L10n.Error.decodingFailed
        case .responseUnsuccessful(let description): return description
        case .requestFailed(let description): return description
        case .custom(let model): return model?.error ?? ""
        }
    }
    
    var description: String { customDescription }
}

// MARK: APIResponseModel
/// Common API response model
struct APIResponseModel<T: Decodable>: Decodable {
    let data: T
}

// MARK: APIErrorResponseModel
/// Common API error response model
struct APIErrorResponseModel: Codable {
    let code: String
    let messages: [String]
    let requestId: String
    let status: Int
    
    var error: String {
        (code.isEmpty ? "" : (code  + ": ")) + (messages.first ?? "")
    }
}

// MARK: EmptyData
/// EmptyData model will be used by any request if data is coming empty in the response
/// This model is used for the status API responses Generic `data` model type
struct EmptyData: Codable {
    
    // MARK: - Init/Deinit
    init() { }
    
    func dataRepresentation() -> Data? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(.iso8601Full)
        do {
            let data = try encoder.encode(self)
            return data
        } catch {
            Logger.log("Data encoding failed")
        }
        return nil
    }
}

/*
 Use this to avoid any parsing failures if some attributes
 of your model don't show up in the JSON AND your attribute is an optional.
 
 This avoids the verbose implementation of init(from decoder: Decoder) for every
 model class.
 
 Usage
 @OptionalDecodable var someProperty: SomeValueType?
 */
@propertyWrapper
struct OptionalDecodable<T: Decodable>: Decodable {
    
    var wrappedValue: T?
    
    init(from decoder: Decoder) throws {
        wrappedValue = try? (try? decoder.singleValueContainer())?.decode(T.self)
    }
    
    init() {
        wrappedValue = nil
    }
}
