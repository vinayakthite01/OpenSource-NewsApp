//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation

class NewsListViewModel: NewsListViewModelProtocol {
    
    /// private `variable`
    private let apiManager: APIManagerProtocol?
    private let navigator: NewsListNavigatorProtocol?
    private var articles: [ArticlesModel]?
    var newsListResponder: ((NewsListUIUpdateCase) -> Void)?
    
    /// `initializer`
    /// - Parameters:
    ///   - navigator: Profile  Navigation
    init(apiManager: APIManagerProtocol, navigator: NewsListNavigatorProtocol) {
        self.apiManager = apiManager
        self.navigator = navigator
    }
    
    /// Get Top Headlines for the country selected by user
    /// - Parameter country: Country
    func getTopHeadlines(forCountry country:String) {
        apiManager?.getTopBusinessHeadlines(country: country, completion: { [weak self] result in
            switch result {
            case .success(let listModel):
                guard let model = listModel else { return }
                self?.articles = listModel?.articles
                self?.newsListResponder?(.success(model: model))
            case .failure(let error):
                self?.newsListResponder?(.error(error: error))
            }
        })
    }
    
    /// Get articles from the list
    /// - Returns: Articles Array
    func getNewsArticles() -> [ArticlesModel]? {
        return articles
    }
    
    /// Get news Article title
    /// - Parameter index: for the index
    /// - Returns: title string
    func getNewsTitle(forIndex index: Int) -> String? {
        return articles?[index].title
    }
    
    /// Get News Description
    /// - Parameter index: for index
    /// - Returns: description String
    func getNewsDescription(forIndex index: Int) -> String? {
        return articles?[index].desciption
    }
    
    /// Get Image url of the news
    /// - Parameter index: for index
    /// - Returns: Image URL String
    func getNewsImageUrl(forIndex index: Int) -> String? {
        return articles?[index].urlToImage
    }
    
    /// Get news URL
    /// - Parameter forIndex: for the index
    /// - Returns: news URL String
    func getNewsUrl(forIndex index: Int) -> String? {
        return articles?[index].url
    }
    
    /// Get Publishsed At description
    /// - Parameter index: for index
    /// - Returns: published at String
    func getNewsPublishedAt(forIndex index: Int) -> String? {
        return articles?[index].publishedAt
    }
    
    /// Get News Content
    /// - Parameter index: for index
    /// - Returns: news content sting
    func getNewsContent(forIndex index: Int) -> String? {
        return articles?[index].content
    }
    
    /// Navigate to article details
    /// - Parameter index: index for the cell.
    func redirectToArticleDetails(forIndex index: Int) {
        if let article = articles?[index] {
            navigator?.showNewsDetails(forArticle: article)
        }
    }
}
