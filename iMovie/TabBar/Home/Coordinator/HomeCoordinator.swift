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
    
    var view: HomeViewController?
    var navigation: IMNavigationViewController?
    var presentationType: PresentationType?
    var viewModel: HomeViewModel!
    
    var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    // MARK: Controllers
    private var detailViewController: MovieDetailViewController!
    
    func start() -> IMNavigationViewController {
        viewModel = HomeViewModel()
        viewModel.delegate = self
        view = HomeViewController(viewModel: viewModel)
        
        navigation = IMNavigationViewController(rootViewController: view!)
        navigation?.tabBarItem.image = #imageLiteral(resourceName: "TAB_HOME")
        navigation?.tabBarItem.title = "Home"
        return navigation!
    }
    
    func stop() {
        view = nil
        navigation = nil
        presentationType = nil
    }
    
    func showMovieDetail(_ movie: Film) {
        guard let navigationController = navigation else { return }
        detailViewController = MovieDetailViewController(movie)
        navigationController.present(detailViewController, animated: true, completion: nil)
    }
}

extension HomeCoordinator: HomeViewModelDelegate {
    func homeViewModelDidSelectMovie(_ viewModel: HomeViewModel, movie: Film) {
        showMovieDetail(movie)
    }
}
