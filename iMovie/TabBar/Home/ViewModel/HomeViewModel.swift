//
//  HomeViewModel.swift
//  iMovie
//
//  Created by bruno on 05/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import Foundation

protocol HomeViewModelCoordinatorDelegate: AnyObject {
    func homeViewModelDidSelectMovie(_ viewModel: HomeViewModel, movie: Film)
}

protocol HomeViewModelViewDelegate: AnyObject {
    func homeViewModelDidFinishLoadNowPlaying(_ viewModel: HomeViewModel)
    func homeViewModelDidFinishLoadTopRated(_ viewModel: HomeViewModel)
    func homeViewModelDidFinishLoadPopular(_ viewModel: HomeViewModel)
}

class HomeViewModel {
    weak var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    weak var viewDelegate: HomeViewModelViewDelegate?
    
    var homeService: HomeService!
    
    var nowPlayingMovies: [Film]?
    var topRatedMovies: [Film]?
    var popularMovies: [Film]?
    
    init() {
        homeService = HomeService()
    }
    
    func requestNowPlaying() {
        homeService.getNowPlaying(onSuccess: { [weak self] films in
            guard let self = self else { return }
            self.nowPlayingMovies = films
            self.viewDelegate?.homeViewModelDidFinishLoadNowPlaying(self)
        }, onFail: { (error) in
            print(error)
        })
    }
    
    func requestTopRated() {
        homeService.getTopRated(onSuccess: { [weak self] films in
            guard let self = self else { return }
            self.topRatedMovies = films
            self.viewDelegate?.homeViewModelDidFinishLoadTopRated(self)
            }, onFail: { (error) in
                print(error)
        })
    }
    
    func requestPopular() {
        homeService.getPopular(onSuccess: { [weak self] films in
            guard let self = self else { return }
            self.popularMovies = films
            self.viewDelegate?.homeViewModelDidFinishLoadPopular(self)
            }, onFail: { (error) in
                print(error)
        })
    }
    
    func didSelectMovie(_ movie: Film?) {
        guard let movie = movie else { return }
        coordinatorDelegate?.homeViewModelDidSelectMovie(self, movie: movie)
    }
}
