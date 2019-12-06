//
//  FavoritesViewModel.swift
//  iMovie
//
//  Created by bruno on 06/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import Foundation

protocol FavoritesViewModelDelegate: AnyObject {
    
}

class FavoritesViewModel {
    weak var delegate: FavoritesViewModelDelegate?
}
