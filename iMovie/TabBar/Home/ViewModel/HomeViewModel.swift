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
    
    var films: [Film]?
    
    init() {
        homeService = HomeService()
        requestNowPlaying()
    }
    
    func requestNowPlaying() {
        homeService.getNowPlaying(onSuccess: { [weak self] films in
            self?.films = films
        }, onFail: { (error) in
            print(error)
        })
    }
}
