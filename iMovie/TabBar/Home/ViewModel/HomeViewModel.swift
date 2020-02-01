//
//  HomeViewModel.swift
//  iMovie
//
//  Created by bruno on 05/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func homeViewModelDidSelectMovie(_ viewModel: HomeViewModel, movie: Film)
}

class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    var homeService: HomeService!
    
    var nowPlayingMovies: [Film]?
    var topRatedMovies: [Film]?
    var popularMovies: [Film]?
    
    init() {
        homeService = HomeService()
    }
    
    func requestNowPlaying(_ completion: CompletionSuccess) {
        homeService.getNowPlaying(onSuccess: { [weak self] films in
            self?.nowPlayingMovies = films
            completion?()
        }, onFail: { (error) in
            print(error)
        })
    }
    
    func requestTopRated(_ completion: CompletionSuccess) {
        homeService.getTopRated(onSuccess: { [weak self] films in
            self?.topRatedMovies = films
            completion?()
            }, onFail: { (error) in
                print(error)
        })
    }
    
    func requestPopular(_ completion: CompletionSuccess) {
        homeService.getPopular(onSuccess: { [weak self] films in
            self?.popularMovies = films
            completion?()
            }, onFail: { (error) in
                print(error)
        })
    }
    
    func didSelectMovie(_ movie: Film?) {
        guard let movie = movie else { return }
        delegate?.homeViewModelDidSelectMovie(self, movie: movie)
    }
}
