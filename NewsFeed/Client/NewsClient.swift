//
//  NewsClient.swift
//  NewsFeed
//
//  Created by Mykyta Oliinyk on 11.07.2022.
//

import Foundation
import Combine
import CombineMoya
import Moya

protocol NewsClientProtocol {
    func requestArticlesPublisher(query: String) -> AnyPublisher<ArticlesResult, MoyaError>
}

class NewsClient: NewsClientProtocol {
    private let provider: MoyaProvider<NewsService>
    private let decoder: JSONDecoder
    
    init(provider: MoyaProvider<NewsService> = MoyaProvider<NewsService>(), decoder: JSONDecoder = defaultDecoder) {
        self.provider = provider
        self.decoder = decoder
    }
    
    func requestArticlesPublisher(query: String) -> AnyPublisher<ArticlesResult, MoyaError> {
        provider.requestPublisher(.artileList(query: query))
            .map(ArticlesResult.self, using: decoder)
            .eraseToAnyPublisher()
    }
    
    private static var defaultDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}

class NewsClientMock: NewsClientProtocol {
    func requestArticlesPublisher(query: String) -> AnyPublisher<ArticlesResult, MoyaError> {
        return Just(
            ArticlesResult(
                status: "200",
                totalResults: 1,
                articles: [
                    ArticleItem(
                        author: "Mock author",
                        title: "Mock title",
                        description: "Mock description",
                        url: "apple.com",
                        urlToImage: "apple.com",
                        publishedAt: Date(),
                        content: "Mock content"
                    )
                ]
            )
        )
        .setFailureType(to: MoyaError.self)
        .eraseToAnyPublisher()
    }
}
