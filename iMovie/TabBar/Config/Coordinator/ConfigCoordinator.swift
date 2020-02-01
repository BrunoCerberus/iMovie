//
//  ConfigCoordinator.swift
//  iMovie
//
//  Created by bruno on 06/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit

class ConfigCoordinator: BaseCoordinator {
    
    typealias V = ConfigViewController
    
    var view: ConfigViewController?
    var navigation: IMNavigationViewController?
    var presentationType: PresentationType?
    
    var viewModel: ConfigViewModel!
    
    func start() -> IMNavigationViewController {
        viewModel = ConfigViewModel()
        viewModel.delegate = self
        view = ConfigViewController(viewModel: viewModel)
        
        navigation = IMNavigationViewController(rootViewController: view!)
        navigation?.tabBarItem.image = #imageLiteral(resourceName: "TAB_CONFIG")
        navigation?.tabBarItem.title = "Profile"
        return navigation!
    }
    
    func stop() {
        view = nil
        navigation = nil
        presentationType = nil
    }
}

extension ConfigCoordinator: ConfigViewModelDelegate {
    
}
