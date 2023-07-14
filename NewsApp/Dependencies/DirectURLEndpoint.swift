//
//  DirectURLEndpoint.swift
//  NewsApp
//
//  Created by Vinayak Thite on 22/08/22.
//

import Foundation

// MARK: Protocol DirectURLEndpointType
protocol DirectURLEndpointType {
    /// Request URL
    var urlPath: String { get }
    
    /// request Method
    var httpMethod: HTTPMethod { get }
}

// MARK: Enum DirectURLEndpoint
enum DirectURLEndpoint {
    // case to load data from url
    case loadDirectURLDetails(url: String)
}

// MARK: extension for DirectURLEndpoint
extension DirectURLEndpoint: DirectURLEndpointType {
    /// Country
    private var country: String {
        switch self {
        case .loadDirectURLDetails(let countryCode):
            return "country=\(countryCode)"
        }
    }
    /// News Category
    private var category: String{ "&category=business" }
    /// API Key
    private var apiKey: String{ "&apiKey=\(Environment.apiKey)" }
    // URL
    var urlPath: String {
        var urlPath = String()
        switch self {
        case .loadDirectURLDetails(let url):
            urlPath = url
        }
        return urlPath
    }
    
    /// request method type
    var httpMethod: HTTPMethod {
        return .get
    }
}
