//
//  NewsListModel.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation

struct NewsListModel: Codable {
    let articles: [news]
}

struct news: Codable {
    let source: [sourceDict]?
    let author: String?
    let title: String?
    let desciption: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct sourceDict: Codable {
    let id: String?
    let name: String?
}
