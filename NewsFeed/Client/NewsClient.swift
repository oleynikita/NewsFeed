//
//  NewsClient.swift
//  NewsFeed
//
//  Created by Mykyta Oliinyk on 11.07.2022.
//

import Foundation
import Moya
import CombineMoya
import Combine

enum NewsService {
    case artileList(querry: String)
    case article(id: String)
}

extension NewsService: TargetType {
    var baseURL: URL {
        URL(string: "https://newsapi.org/v2")!
    }
    
    var path: String {
        switch self {
        case .artileList(_):
            return "/everything"
        case .article(_):
            return "/everything"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .article(let id):
            return .requestPlain
        case .artileList(let querry):
            return .requestParameters(parameters: ["q" : querry, "apiKey" : "1f569f217bb94447ac173f100dcfeef5"], encoding: URLEncoding.queryString)
        }
        
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

struct ArticleResultItem: Codable, Hashable {
    let author: String?
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: Date
    let content: String
    
    var stringDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: publishedAt)
    }
}

struct ArticlesResult: Codable, Hashable {
    let status: String
    let totalResults:Int
    let articles: [ArticleResultItem]
}

class NewsClient {
    private let provider = MoyaProvider<NewsService>()
    
    func requestArticles(querry: String, completion: @escaping ((Result<ArticlesResult, NewsClientError>) -> Void)) {
        provider.request(.artileList(querry: querry)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let result = try decoder.decode(ArticlesResult.self, from: response.data)
                    completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(.decodingError))
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(.networkError))
            }
        }
    }
}

enum NewsClientError: Error {
    case decodingError
    case networkError
}
