//
//  HomeViewModel.swift
//  iMovie
//
//  Created by bruno on 05/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    
}

class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    var homeService: HomeService!
    
    var nowPlayingMovies: [Film]?
    var topRatedMovies: [Film]?
    var popularMovies: [Film]?
    
    init() {
        homeService = HomeService()
        requestNowPlaying()
    }
    
    func requestNowPlaying() {
        homeService.getNowPlaying(onSuccess: { [weak self] films in
            self?.nowPlayingMovies = films
        }, onFail: { (error) in
            print(error)
        })
    }
    
    func requestTopRated() {
        homeService.getTopRated(onSuccess: { [weak self] films in
            self?.topRatedMovies = films
            }, onFail: { (error) in
                print(error)
        })
    }
    
    func requestPopular() {
        homeService.getPopular(onSuccess: { [weak self] films in
            self?.popularMovies = films
            }, onFail: { (error) in
                print(error)
        })
    }
}
