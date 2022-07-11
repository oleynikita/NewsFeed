//
//  HomeView.swift
//  NewsFeed
//
//  Created by Mykyta Oliinyk on 11.07.2022.
//

import SwiftUI

struct HomeView: View {
    
    let articles: [ArticleResultItem]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(articles, id: \.self) { article in
                    NewsItemView(item: article)
                }
            }
        }
    }
}

struct NewsItemView: View {
    let item: ArticleResultItem
    
    var body: some View {
        HStack {
            Text(item.author ?? "Author unknown")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(articles: [
            ArticleResultItem(
                author: "Tim Cook",
                title: "WWDC22",
                description: "One More Thing",
                url: "apple.com",
                urlToImage: "apple.com",
                publishedAt: "22.02.02",
                content: "Welcome to WWDC 22"
            )
        ])
    }
}
