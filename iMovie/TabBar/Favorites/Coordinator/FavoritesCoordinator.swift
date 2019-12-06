//
//  FavoritesCoordinator.swift
//  iMovie
//
//  Created by bruno on 06/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit

class FavoritesCoordinator: BaseCoordinator {
    
    typealias V = FavoritesViewController
    
    var view: FavoritesViewController?
    var navigation: IMNavigationViewController?
    var presentationType: PresentationType?
    
    var viewModel: FavoritesViewModel!
    
    func start() -> IMNavigationViewController {
        viewModel = FavoritesViewModel()
        viewModel.delegate = self
        view = FavoritesViewController(viewModel: viewModel)
        
        navigation = IMNavigationViewController(rootViewController: view!)
        navigation?.tabBarItem.image = #imageLiteral(resourceName: "TAB_FAVORITE")
        navigation?.tabBarItem.title = "Favoritos"
        return navigation!
    }
    
    func stop() {
        view = nil
        navigation = nil
        presentationType = nil
    }
}

extension FavoritesCoordinator: FavoritesViewModelDelegate {
    
}
