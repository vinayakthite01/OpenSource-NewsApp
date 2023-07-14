//
//  DependencyContainer.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation

// MARK: DependencyContainerProtocol
/*
 Protocol to force store required services, dependencies or other resources
 Workes as dependencies container
 */
protocol DependencyContainerProtocol {

    // This protocol will be confirming to the services
    // needed like API manager, firebase manager,
    // UserManager etc.
    
    /// API Manager
    var apiManager: APIManagerProtocol { get }
    
    /// Session Manager
    var sessionManager: SessionManagerProtocol { get }
}

// MARK: Confirming to Resource Protocol
final class DependencyContainer: DependencyContainerProtocol {
    
    // Accessible resources
    var apiManager: APIManagerProtocol
    var sessionManager: SessionManagerProtocol
    
    /// Takes all the dependencies object for self initialization
    /// - Parameters:
    ///   - contentstackManager: Contentstack manager
    ///   - keyboardManager: Keyboard Manager
    ///   - apiManager: API Manager
    ///   - storageManager: Local storage managers
    ///   - algoliaManager: Algolia manager
    ///   - appTrackingManager: App Tracking manager
    ///   - sessionManager: Session manager
    init(apiManager: APIManagerProtocol, sessionManager: SessionManagerProtocol) {
        self.apiManager = apiManager
        self.sessionManager = sessionManager
    }
}

// MARK: Allocator for DependencyContainer
final class DependenciesAllocator {
    // Allocates all dependencies
    static func allocate() -> DependencyContainerProtocol {
        let sessionManager = SessionManager()
        return DependencyContainer(apiManager: APIManager(sessionManager: sessionManager),
                                   sessionManager: sessionManager)
    }
}
