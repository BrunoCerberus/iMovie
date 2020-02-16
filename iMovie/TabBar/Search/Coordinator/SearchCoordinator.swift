//
//  SearchCoordinator.swift
//  iMovie
//
//  Created by Bruno on 16/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation

class SearchCoordinator: BaseCoordinator {
    typealias V = SearchViewController
    
    var view: SearchViewController?
    var navigation: IMNavigationViewController?
    var presentationType: PresentationType?
    var viewModel: SearchViewModel!
    
    func start() -> IMNavigationViewController {
        viewModel = SearchViewModel()
        viewModel.coordinatorDelegate = self
        view = SearchViewController(viewModel: viewModel)
        
        navigation = IMNavigationViewController(rootViewController: view!)
        navigation?.tabBarItem.image = #imageLiteral(resourceName: "TAB_SEARCH")
        navigation?.tabBarItem.title = "Search"
        return navigation!
    }
    
    func stop() {
        view = nil
        navigation = nil
        presentationType = nil
    }
}

extension SearchCoordinator: SearchViewModelCoordinatorDelegate {
    
}
