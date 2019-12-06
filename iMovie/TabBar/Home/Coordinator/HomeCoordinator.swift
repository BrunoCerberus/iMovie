//
//  HomeCoordinator.swift
//  iMovie
//
//  Created by bruno on 05/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit

class HomeCoordinator: BaseCoordinator {
    
    typealias V = HomeViewController
    
    var window: UIWindow
    var view: HomeViewController?
    var navigation: IMNavigationViewController?
    var presentationType: PresentationType?
    var viewModel: HomeViewModel!
    
    var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    required init(window: UIWindow) {
        self.window = window
    }
    
    func start() -> IMNavigationViewController {
        viewModel = HomeViewModel()
        viewModel.delegate = self
        view = HomeViewController(viewModel: viewModel)
        
        navigation = IMNavigationViewController(rootViewController: view!)
        navigation?.tabBarItem.image = #imageLiteral(resourceName: "TAB_HOME")
        navigation?.tabBarItem.title = "Início"
        return navigation!
    }
    
    func stop() {
        view = nil
        navigation = nil
        presentationType = nil
    }
}

extension HomeCoordinator: HomeViewModelDelegate {
    
}
