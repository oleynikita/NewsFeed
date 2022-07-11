//
//  NewsFeedApp.swift
//  NewsFeed
//
//  Created by Mykyta Oliinyk on 11.07.2022.
//

import SwiftUI
import Combine

@main
struct NewsFeedApp: App {
    
    let client = NewsClient()
    @State private var cancellables = Set<AnyCancellable>()
    
    var body: some Scene {
        WindowGroup {
            HomeView(articles: [])
                .onAppear {
                    client.requestArticles(querry: "apple") { result in
                        switch result {
                        case.success(let articleModel):
                            print(articleModel)
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
        }
    }
}
