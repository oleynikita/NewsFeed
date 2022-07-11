//
//  NewsFeedCore.swift
//  NewsFeed
//
//  Created by Mykyta Oliinyk on 11.07.2022.
//

import Foundation
import ComposableArchitecture
import Moya

public struct HomeNewsState: Equatable {
    var articles: [ArticleItem]
    var isLoading: Bool = false
    var searchQuerry: String = "Apple"
}

public enum HomeNewsAction {
    case onAppear
    case onSearchEdit(String)
    case onSearchSend
    case receivedResult(Result<ArticlesResult, MoyaError>)
    case loadArticles
}

public struct HomeNewsEnvironment {
    let client: NewsClientProtocol
}

public var homeReducer = Reducer<HomeNewsState, HomeNewsAction, HomeNewsEnvironment> { (state, action, environment) in
    switch action {
    case .onAppear:
        return Effect(value: .loadArticles)

    case .onSearchEdit(let newQuerry):
        state.searchQuerry = newQuerry
        return .none

    case .onSearchSend:
        return Effect(value: .loadArticles)
        
    case .loadArticles:
        state.isLoading = true
        return environment.client
            .requestArticlesPublisher(querry: state.searchQuerry)
            .catchToEffect { result in
                .receivedResult(result)
            }
        
    case .receivedResult(.success(let result)):
        state.articles = result.articles
        state.isLoading = false
        return .none
    
    case .receivedResult(.failure(let error)):
        print(error)
        state.isLoading = false
        return .none
    }
}
