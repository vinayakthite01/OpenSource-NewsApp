//
//  NewsListProtocol.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation

protocol NewsListViewModelProtocol {
    func getTopHeadlines(forCountry country:String)
}

protocol NewsListNavigatorProtocol {
    func showNewsDetails()
}

enum NewsListUIUpdateCase {
    case success
    case error(error: APIError)
}
