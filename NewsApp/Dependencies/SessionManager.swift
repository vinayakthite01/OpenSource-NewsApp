//
//  SessionManager.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation

/// `SessionManager Protocol`
protocol SessionManagerProtocol: AnyObject {

}

/// `SessionManager`
final class SessionManager: SessionManagerProtocol {
    
    let apiKey = "13602569df7443ffaa7bac70d5b0a4b0"
    
    /// `initializer`
    /// - Parameters:
    ///   - storageManager: Storage Manager
    init() {
    }
}
