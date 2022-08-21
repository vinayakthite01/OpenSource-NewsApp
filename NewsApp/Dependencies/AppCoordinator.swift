//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import UIKit

// MARK: AppCoordinator protocol
protocol AppCoordinatorProtocol: Coordinator {
    
}

// MARK: AppCoordinator will be launched at the very beginning
final class AppCoordinator: AppCoordinatorProtocol {
    private var window: UIWindow
    private(set) var dependencies: DependencyContainerProtocol
    private(set) var navigationController: NewsAppNavigationControllerProtocol

    /// `initializer`
    /// - Parameters:
    ///   - window: app window
    ///   - dependencies: Dependency Container Object
    init(window: UIWindow, dependencies: DependencyContainerProtocol) {
        let navigationController: NewsAppNavigationControllerProtocol = NewsAppNavigationController()
        self.dependencies = dependencies
        window.rootViewController = navigationController as? NewsAppNavigationController
        window.makeKeyAndVisible()

        self.navigationController = navigationController
        self.window = window
    }

    /// start the flow
    func start() {
               Logger.log("Environment.rootURL")
    }
}
