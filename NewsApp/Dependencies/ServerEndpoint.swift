//
//  ServerEndpoint.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation

enum ServerEndpoint {
    /// User
    case getTopHeadlines(countryCode: String)

}

extension ServerEndpoint: EndPointType {
    /// scheme will be https
    var scheme: String { "https" }
    /// base URL
    var baseURL: String { Environment.serverURL }
    /// api path
    private var middlePath: String { "v2/top-headlines?" }
    /// Country
    private var country: String {
        switch self {
        case .getTopHeadlines(let countryCode):
            return "country=\(countryCode)"
        }
    }
    /// News Category
    private var category: String{ "&category=business" }
    /// API Key
    private var apiKey: String{ "&apiKey=\(Environment.apiKey)" }
    /// URL Path
    var path: String {
        return middlePath + country + category + apiKey
    }
    
    /// request method type
    var httpMethod: HTTPMethod {
        switch self {
        case .getTopHeadlines:
               return .get
        }
    }
    /// parameters passing
    var parameters: [URLQueryItem]? { nil }
    /// Header params
    var headers: [HTTPHeader]? {
        return [HTTPHeader.content("application/json")]
    }
    /// data (body) passing as params
    var data: Data? {
        switch self {
        
        case .getTopHeadlines:
            return nil
        }
    }
}
