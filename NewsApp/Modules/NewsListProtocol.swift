//
//  NewsListProtocol.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation

protocol NewsListViewModelProtocol {
    
}

protocol NewsListNavigatorProtocol {
    
}

enum NewsListUIUpdateCase {
    case success
    case error(error: APIError)
}
