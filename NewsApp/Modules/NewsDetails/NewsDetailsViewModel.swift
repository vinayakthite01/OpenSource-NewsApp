//
//  NewsDetailsViewModel.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation

class NewsDetailsViewModel: NewsDetailsViewModelProtocol {
    /// private `variable`
    private let apiManager: APIManagerProtocol
    private let navigator: NewsDetailsNavigatorProtocol
    private var article: ArticlesModel
    
    
    /// `initializer`
    /// - Parameters:
    ///   - navigator: Profile  Navigation
    init(apiManager: APIManagerProtocol, navigator: NewsDetailsNavigatorProtocol, article: ArticlesModel) {
        self.apiManager = apiManager
        self.navigator = navigator
        self.article = article
    }
    
    func getNewsTitle() -> String? {
        return article.title
    }
    
    func getNewsContent() -> String? {
        return article.content
    }
    
    func getNewsImageUrl() -> String? {
        return article.urlToImage
    }
    
}
