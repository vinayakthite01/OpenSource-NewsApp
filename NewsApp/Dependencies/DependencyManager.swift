//
//  DependencyManager.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation

/// Protocol for dependency managers
protocol DependencyManagerProtocol {
    
    /// Dependency initializer
    init()
    
    /// Starts the dependency
    func start()
    
    /// Terminates the dependency
    func terminate()
}
