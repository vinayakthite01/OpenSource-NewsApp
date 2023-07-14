//
//  NewsBuilder.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import UIKit

protocol NewsListBuilderProtocol {
    /// Build Profile stack
    /// - Returns: UIViewController
    func build(with navigator: NewsListNavigatorProtocol) -> UIViewController
}

struct NewsListBuilder: NewsListBuilderProtocol {
    
    /// API Manager
    let apiManager: APIManagerProtocol
    
    /// Build Profile stack
    func build(with navigator: NewsListNavigatorProtocol) -> UIViewController {
        let newsViewController = StoryboardScene.News.newsList.instantiate { coder in
            let viewModel = NewsListViewModel(apiManager: apiManager, navigator: navigator)
            return NewsList(coder: coder, viewModel: viewModel)
        }

        return newsViewController
    }
}
