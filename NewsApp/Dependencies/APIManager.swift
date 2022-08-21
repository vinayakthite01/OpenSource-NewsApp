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
    /// Session Manager
    private let sessionManager: SessionManagerProtocol


    /// `initializer`
    /// - Parameters:
    ///   - sessionManager: Session Manager
    init(sessionManager: SessionManagerProtocol) {
        self.serverRouter = Router<ServerEndpoint>()
        self.sessionManager = sessionManager
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
        serverRouter.request(.getTopHeadlines(countryCode: "us"), decode: { json -> NewsListModel? in
            guard let results = json as? NewsListModel? else { return  nil }
            return results
        }, completion: completion)
    }
}
