//
//  NewsListProtocol.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation

protocol NewsListViewModelProtocol {
    var newsListResponder: ((NewsListUIUpdateCase) -> Void)? { get set }
    
    /// Get Top Headlines for the country selected by user
    /// - Parameter country: Country
    func getTopHeadlines(forCountry country:String)
    
    /// Get articles from the list
    /// - Returns: Articles Array
    func getNewsArticles() -> [ArticlesModel]?
    
    /// Get news Article title
    /// - Parameter index: for the index
    /// - Returns: title string
    func getNewsTitle(forIndex index: Int) -> String?
    
    /// Get News Description
    /// - Parameter index: for index
    /// - Returns: description String
    func getNewsDescription(forIndex index: Int) -> String?
    
    /// Get Image url of the news
    /// - Parameter index: for index
    /// - Returns: Image URL String
    func getNewsImageUrl(forIndex index: Int) -> String?
    
    /// Get news URL
    /// - Parameter forIndex: for the index
    /// - Returns: news URL String
    func getNewsUrl(forIndex index: Int) -> String?
    
    /// Get Publishsed At description
    /// - Parameter index: for index
    /// - Returns: published at String
    func getNewsPublishedAt(forIndex index: Int) -> String?
    
    /// Get News Content
    /// - Parameter index: for index
    /// - Returns: news content sting
    func getNewsContent(forIndex index: Int) -> String?
    
    /// Navigate to article details
    /// - Parameter index: index for the cell.
    func redirectToArticleDetails(forIndex index: Int)
}

protocol NewsListNavigatorProtocol {
    func showNewsDetails(forArticle article: ArticlesModel)
}

enum NewsListUIUpdateCase {
    case success(model: NewsListModel)
    case error(error: APIError)
}
