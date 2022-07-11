//
//  NewsService.swift
//  NewsFeed
//
//  Created by Mykyta Oliinyk on 11.07.2022.
//

import Foundation
import Moya

enum NewsService {
    case artileList(query: String)
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
            return "/news"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .article(let id):
            return .requestParameters(parameters: ["id" : id, "apiKey" : apiKey], encoding: URLEncoding.queryString)
        case .artileList(let query):
            return .requestParameters(parameters: ["q" : query, "apiKey" : apiKey], encoding: URLEncoding.queryString)
        }
        
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    private var apiKey: String {
        "1f569f217bb94447ac173f100dcfeef5"
    }
}
