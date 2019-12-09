//
//  Movie.swift
//  iMovie
//
//  Created by bruno on 09/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import Foundation

struct FilmsReturn: IMCodable {
    let data: [Film]?
    let page, totalResults: Int?
    let dates: Dates?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case dates
        case totalPages = "total_pages"
        case data = "results"
    }
}

struct Dates: IMCodable {
    let maximum, minimum: String?
}

struct Film: IMCodable {
    let voteCount, id: Int?
    let video: Bool?
    let voteAverage: Double?
    let title: String?
    let popularity: Double?
    let posterPath: String?
    let originalLanguage: String?
    let originalTitle: String?
    let genreIDS: [Int]?
    let backdropPath: String?
    let adult: Bool?
    let overview, releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id, video
        case voteAverage = "vote_average"
        case title, popularity
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult, overview
        case releaseDate = "release_date"
    }
}
