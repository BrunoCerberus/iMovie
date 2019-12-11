//
//  HomeService.swift
//  iMovie
//
//  Created by bruno on 09/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import Foundation

class HomeService: IMConfig<HomeAPI> {
    func getNowPlaying(onSuccess: @escaping ([Film]) -> Void, onFail: @escaping (String) -> Void) {
        fetch(target: .nowPlaying, dataType: FilmsReturn.self) { (result, _) in
            switch result {
            case .success(let response):
                onSuccess(response.data ?? [Film]())
            case .failure(let error):
                onFail(error.localizedDescription)
            }
        }
    }
    
    func getTopRated(onSuccess: @escaping ([Film]) -> Void, onFail: @escaping (String) -> Void) {
        fetch(target: .topRated, dataType: FilmsReturn.self) { (result, _) in
            switch result {
            case .success(let response):
                onSuccess(response.data ?? [Film]())
            case .failure(let error):
                onFail(error.localizedDescription)
            }
        }
    }
    
    func getPopular(onSuccess: @escaping ([Film]) -> Void, onFail: @escaping (String) -> Void) {
        fetch(target: .popular, dataType: FilmsReturn.self) { (result, _) in
            switch result {
            case .success(let response):
                onSuccess(response.data ?? [Film]())
            case .failure(let error):
                onFail(error.localizedDescription)
            }
        }
    }
}
