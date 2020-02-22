//
//  HomeAPI.swift
//  iMovie
//
//  Created by bruno on 09/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import Foundation

enum HomeAPI {
    case nowPlaying
    case topRated
    case popular(page: Int)
}

extension HomeAPI: Fetcher {
    var path: String {
        switch self {
        case .nowPlaying:
            return "/now_playing"
        case .topRated:
            return "/top_rated"
        case .popular(let page):
            return "/popular?page=\(page)"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .nowPlaying, .topRated, .popular:
            return .GET
        }
    }
    
    var task: IMCodable? {
        switch self {
        case .nowPlaying, .topRated, .popular:
            return nil
        }
    }
}
