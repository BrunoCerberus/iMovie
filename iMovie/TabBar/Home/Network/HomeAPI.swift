//
//  HomeAPI.swift
//  iMovie
//
//  Created by bruno on 09/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import Foundation
import Alamofire

enum HomeAPI {
    case nowPlaying
    case topRated
    case popular
    
    //case nowPlaying(Film) POST Sample
}

extension HomeAPI: Fetcher {
    var path: String {
        switch self {
        case .nowPlaying:
            return "/now_playing"
        case .topRated:
            return "/top_rated"
        case .popular:
            return "/popular"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .nowPlaying, .topRated, .popular:
            return .get
        }
    }
    
    var task: IMCodable? {
        switch self {
        case .nowPlaying, .topRated, .popular:
            return nil
//        case .nowPlaying(let body): POST Sample
//            return body
        }
    }
}
