//
//  Article.swift
//  NewsApp
//
//  Created by Meric Alp on 4.04.2023.
//

import Foundation

struct ArticleResponse: Decodable{
    let articles: [Article]
}

struct Article: Decodable{
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
}
