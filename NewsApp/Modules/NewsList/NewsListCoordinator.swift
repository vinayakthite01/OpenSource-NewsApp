//
//  NewsListCoordinator.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation

protocol NewsListCoordinatorProtocol: Coordinator {
    
}

class NewsListCoordinator: NewsListCoordinatorProtocol {
    
    /// private `variables`
    private(set) var dependencies: DependencyContainerProtocol
    private(set) var navigationController: NewsAppNavigationControllerProtocol
    private let newsBuilder: NewsListBuilderProtocol
    
    /// `initializer`
    /// - Parameters:
    ///   - dependencies: Dependency Container Object
    ///   - navigationController: MWHNavigation Controller
    init(dependencies: DependencyContainerProtocol,
         navigationController: NewsAppNavigationControllerProtocol) {
        self.dependencies = dependencies
        self.navigationController = navigationController
        self.newsBuilder = NewsListBuilder(apiManager: dependencies.apiManager)
    }

    /// start the flow
    func start() {
        let viewController = newsBuilder.build(with: self)
        navigationController.push(viewController: viewController, animated: true)
    }
}

extension NewsListCoordinator: NewsListNavigatorProtocol {
    func showNewsDetails() {
//        let viewController = newsBuilder.build(with: self)
//        navigationController.push(viewController: viewController, animated: true)
    }
}
