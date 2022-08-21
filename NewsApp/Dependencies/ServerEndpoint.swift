//
//  ServerEndpoint.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation

enum ServerEndpoint {
    /// User
    case getUploadURL
}

extension ServerEndpoint: EndPointType {
    /// scheme will be https
    var scheme: String { "https" }
    /// base URL
    var baseURL: String { "Environment.serverlessURL" }
    /// api path
    private var middlePath: String { "/dev" }
    /// path component
    var path: String {
        var finalPath = String()
        
        switch self {
        case .getUploadURL:
            finalPath = "/profile-image/jpeg"
        }
        
        return middlePath + finalPath
    }
    /// request method type
    var httpMethod: HTTPMethod {
        switch self {
        case .getUploadURL:
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
        case .getUploadURL:
            return nil
        }
    }
}
