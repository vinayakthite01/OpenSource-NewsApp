//
//  NewsListModel.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation

struct NewsListModel: Decodable {
    let articles: [ArticlesModel]
    let status: String?
    let totalResults: Int?
}

struct ArticlesModel: Decodable {
    // Article Keys:
    let author: String?
    let title: String?
    let desciption: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
}
