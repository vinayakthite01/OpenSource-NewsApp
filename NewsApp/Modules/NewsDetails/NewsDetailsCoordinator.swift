//
//  NewsDetailsCoordinator.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation

protocol NewsDetailsCoordinatorProtocol: Coordinator {
    
}

class NewsDetailsCoordinator: NewsListCoordinatorProtocol {
    
    /// private `variables`
    private(set) var dependencies: DependencyContainerProtocol
    private(set) var navigationController: NewsAppNavigationControllerProtocol
    private let newsBuilder: NewsDetailsBuilderProtocol
    private let newsArticle: ArticlesModel
    
    /// `initializer`
    /// - Parameters:
    ///   - dependencies: Dependency Container Object
    ///   - navigationController: MWHNavigation Controller
    init(dependencies: DependencyContainerProtocol,
         navigationController: NewsAppNavigationControllerProtocol, articles: ArticlesModel) {
        self.dependencies = dependencies
        self.navigationController = navigationController
        self.newsBuilder = NewsDetailsBuilder(apiManager: dependencies.apiManager)
        self.newsArticle = articles
    }

    /// start the flow
    func start() {
        let viewController = newsBuilder.build(with: self, article: newsArticle)
        navigationController.push(viewController: viewController, animated: true)
    }
}

extension NewsDetailsCoordinator: NewsDetailsNavigatorProtocol {

}
