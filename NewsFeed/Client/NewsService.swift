//
//  NewsService.swift
//  NewsFeed
//
//  Created by Mykyta Oliinyk on 11.07.2022.
//

import Foundation
import Moya

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
            return "/news"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .article(let id):
            return .requestParameters(parameters: ["id" : id, "apiKey" : "1f569f217bb94447ac173f100dcfeef5"], encoding: URLEncoding.queryString)
        case .artileList(let querry):
            return .requestParameters(parameters: ["q" : querry, "apiKey" : "1f569f217bb94447ac173f100dcfeef5"], encoding: URLEncoding.queryString)
        }
        
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
