//
//  SearchViewModel.swift
//  iMovie
//
//  Created by Bruno on 16/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation

protocol SearchViewModelCoordinatorDelegate: AnyObject {
    
}

protocol SearchViewModelViewDelegate: AnyObject {
    
}

class SearchViewModel {
    
    weak var coordinatorDelegate: SearchViewModelCoordinatorDelegate?
    weak var viewDelegate: SearchViewModelViewDelegate?
}
