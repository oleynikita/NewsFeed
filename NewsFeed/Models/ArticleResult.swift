//
//  ArticleResult.swift
//  NewsFeed
//
//  Created by Mykyta Oliinyk on 11.07.2022.
//

import Foundation

public struct ArticlesResult: Codable, Hashable {
    let status: String
    let totalResults:Int
    let articles: [ArticleItem]
}
