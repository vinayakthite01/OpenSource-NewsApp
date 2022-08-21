//
//  NewsListProtocol.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation

protocol NewsListViewModelProtocol {
    var newsListResponder: ((NewsListUIUpdateCase) -> Void)? { get set }
    func getTopHeadlines(forCountry country:String)
}

protocol NewsListNavigatorProtocol {
    func showNewsDetails()
}

enum NewsListUIUpdateCase {
    case success(model: NewsListModel)
    case error(error: APIError)
}
