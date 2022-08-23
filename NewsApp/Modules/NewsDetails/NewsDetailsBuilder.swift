//
//  NewsDetailsBuilder.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation
import UIKit

protocol NewsDetailsBuilderProtocol {
    /// Build Profile stack
    /// - Parameters:
    ///   - navigator: navigator Protocol instance
    ///   - article: article 
    /// - Returns: NewsDetails View Controller
    func build(with navigator: NewsDetailsNavigatorProtocol, article: ArticlesModel) -> UIViewController
}

struct NewsDetailsBuilder: NewsDetailsBuilderProtocol {

    /// API Manager
    let apiManager: APIManagerProtocol
    
    /// Build Profile stack
    func build(with navigator: NewsDetailsNavigatorProtocol, article: ArticlesModel) -> UIViewController {
        let newsViewController = StoryboardScene.News.newsDetails.instantiate { coder in
            let viewModel = NewsDetailsViewModel(apiManager: apiManager, navigator: navigator, article: article)
            return NewsDetails(coder: coder, viewModel: viewModel)
        }

        return newsViewController
    }
}
