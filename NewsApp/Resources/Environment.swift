//
//  Environment.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation

public enum Environment {
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let serverURL = "SERVER_URL"
            static let apiKey = "API_KEY"
        }
    }
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("*** Plist file not found ***")
        }
        return dict
    }()
    
    // MARK: - Plist values
    static let serverURL: String = {
        guard let endevourURLstring = Environment.infoDictionary[Keys.Plist.serverURL] as? String,
              endevourURLstring.count > 0 else {
            fatalError("*** Server API key not set in plist for this environment ***")
        }
        return endevourURLstring
    }()
    
    static let apiKey: String = {
        guard let apiKey = Environment.infoDictionary[Keys.Plist.apiKey] as? String else {
            fatalError("*** API Key not set in plist for this environment ***")
        }
        return apiKey
    }()
}
