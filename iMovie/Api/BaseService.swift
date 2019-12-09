//
//  BaseService.swift
//  iMovie
//
//  Created by bruno on 09/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import Foundation

enum API {
    static let baseUrl = "https://api.themoviedb.org/3/movie"
    static let baseImagesUrl = "https://image.tmdb.org/t/p/w500/"
    static let ApiKey = "3f767426720c364fcf885cdb5d079d5f"
    
    static var apiEndPoint: String {
        let value = "\(API.baseUrl)"
        return value
    }
    
    //Now playing
    static let getNowPlaying = "\(apiEndPoint)/now_playing"
    static let getTopRated = "\(apiEndPoint)/top_rated"
    static let getPopular = "\(apiEndPoint)/popular"
}
