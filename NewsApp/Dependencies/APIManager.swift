//
//  APIManager.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation


/// `API (Endevour & Middleware) Manager`
final class APIManager {
    /// Router to call custom get/post request via Endevour
    private let serverRouter: Router<ServerEndpoint>
    // Router to call Direct URLs
    private let directUrlRouter: DirectURLRouter<DirectURLEndpoint>
    /// Session Manager
    private let sessionManager: SessionManagerProtocol


    /// `initializer`
    /// - Parameters:
    ///   - sessionManager: Session Manager
    init(sessionManager: SessionManagerProtocol) {
        self.sessionManager = sessionManager
        self.serverRouter = Router<ServerEndpoint>()
        self.directUrlRouter = DirectURLRouter<DirectURLEndpoint>()
    }
}

// ----------------------------------
// MARK: - APIManager Protocol Request -
//

/// `APIManager Protocol`
protocol APIManagerProtocol: AnyObject {
    /// `News` API
    func getTopBusinessHeadlines(country:String, completion: @escaping (Result<NewsListModel?, APIError>) -> Void)
}

extension APIManager: APIManagerProtocol {
    /// `News` API
    func getTopBusinessHeadlines(country:String, completion: @escaping (Result<NewsListModel?, APIError>) -> Void) {
        let urlString = GenerateAPI.scheme + Environment.serverURL + GenerateAPI.urlPath + GenerateAPI.country + country + ChooseOperator.questionMark + GenerateAPI.category + ChooseOperator.and + GenerateAPI.apiKeyConst + GenerateAPI.apiKey
        directUrlRouter.request(.loadDirectURLDetails(url: urlString), decode: { json -> NewsListModel? in
            guard let results = json as? NewsListModel? else { return  nil }
            return results
        }, completion: completion)
    }
}
