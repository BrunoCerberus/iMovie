//
//  Coordinator.swift
//  iMovie
//
//  Created by bruno on 06/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var window: UIWindow { get set }
    
    init(window: UIWindow)
    
    func start()
}
