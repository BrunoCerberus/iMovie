//
//  ConfigViewModel.swift
//  iMovie
//
//  Created by bruno on 06/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import Foundation

protocol ConfigViewModelDelegate: AnyObject {
    
}

class ConfigViewModel {
    weak var delegate: ConfigViewModelDelegate?
}
