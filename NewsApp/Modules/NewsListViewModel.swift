//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation

class NewsListViewModel: NewsListViewModelProtocol {
    
    /// private `variable`
    private let apiManager: APIManagerProtocol?
    private let navigator: NewsListNavigatorProtocol?
    
    
    /// `initializer`
    /// - Parameters:
    ///   - navigator: Profile  Navigation
    init(apiManager: APIManagerProtocol, navigator: NewsListNavigatorProtocol) {
        self.apiManager = apiManager
        self.navigator = navigator
    }
    
    /// Get Top Headlines for the country selected by user
    /// - Parameter country: Country
    func getTopHeadlines(forCountry country:String) {
        apiManager?.getTopBusinessHeadlines(country: country, completion: { [weak self] result in
//            switch result {
//            case .success(_):
//                <#code#>
//            case .failure(_):
//                <#code#>
//            }
        })
    }
}
