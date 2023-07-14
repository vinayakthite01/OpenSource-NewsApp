//
//  NewsDetailsProtocols.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation

protocol NewsDetailsViewModelProtocol {
    func getNewsTitle() -> String?
    func getNewsContent() -> String?
    func getNewsImageUrl() -> String?
}

protocol NewsDetailsNavigatorProtocol {
}

