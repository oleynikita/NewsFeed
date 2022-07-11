//
//  NewsFeedApp.swift
//  NewsFeed
//
//  Created by Mykyta Oliinyk on 11.07.2022.
//

import SwiftUI
import Combine
import ComposableArchitecture

@main
struct NewsFeedApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(store: homeStore)
                .onAppear {
                    let appearance = UINavigationBarAppearance()
                    appearance.configureWithDefaultBackground()
                    UINavigationBar.appearance().scrollEdgeAppearance = appearance
                }
        }
    }
    
    private var homeStore: Store<HomeNewsState, HomeNewsAction> {
        Store(
            initialState: HomeNewsState(articles: []),
            reducer: homeReducer,
            environment: HomeNewsEnvironment(
                client: NewsClient()
            )
        )
    }
}
