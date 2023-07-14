//
//  GenerateAPI.swift
//  NewsApp
//
//  Created by Vinayak Thite on 22/08/22.
//

import Foundation

enum ChooseOperator {
    static let and = "&"
    static let questionMark = "?"
}

enum GenerateAPI {
    static let scheme = "https://"
    static let urlPath = "/v2/top-headlines?"
    static let queryParam = "q="
    static let country = "country="
    static let category = "category=business"
    static let apiKeyConst = "apiKey="
    static let apiKey = Environment.apiKey
}
