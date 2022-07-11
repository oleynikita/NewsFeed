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
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(articles, id: \.self) { article in
                        Button(action: {}) {
                            NewsItemView(item: article)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .background(Color.gray.opacity(0.1))
    }
}

struct NewsItemView: View {
    let item: ArticleResultItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Circle()
                    .frame(width: 50, height: 50)
                Text(item.author ?? "Author unknown")
                Spacer()
                Text(item.stringDate)
            }
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.title)
                    .foregroundColor(.primary)
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Text(item.content)
        }
        .padding()
        .background(Color.white)
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
                publishedAt: Date(),
                content: "Welcome to WWDC 22"
            ),
            ArticleResultItem(
                author: "Tim Cook 2",
                title: "WWDC22",
                description: "One More Thing",
                url: "apple.com",
                urlToImage: "apple.com",
                publishedAt: Date(),
                content: "Welcome to WWDC 22 sdf  sdf sdfsd dsfsdfsd dsfdsf sdfdsfsd fsdf sdfdsfdsf sdfsdfsdf"
            )
        ])
    }
}
