//
//  ArticleItem.swift
//  NewsFeed
//
//  Created by Mykyta Oliinyk on 11.07.2022.
//

import Foundation

struct ArticleItem: Codable, Hashable {
    let author: String?
    let title: String
    let description: String
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String
}

extension ArticleItem {
    var stringDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: publishedAt)
    }
    
    var urlObject: URL {
        URL(string: url) ?? URL(string: "https://apple.com")!
    }
}

extension ArticleItem {
    static var mock: ArticleItem {
        ArticleItem(
            author: "Tim Cook",
            title: "WWDC22",
            description: "One More Thing",
            url: "apple.com",
            urlToImage: "apple.com",
            publishedAt: Date(),
            content: "Welcome to WWDC 22"
        )
    }
}
