//
//  TabBarCoordinator.swift
//  iMovie
//
//  Created by bruno on 05/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

protocol TabBarCoordinatorDelegate: AnyObject {
    func tabBarCoordinatorDidFinish(tabBarCoordinator: TabBarCoordinator)
}

import UIKit

class TabBarCoordinator: BaseCoordinator {
    
    var window: UIWindow
    weak var delegate: TabBarCoordinatorDelegate?
    
    var view: HomeViewController?
    var navigation: IMNavigationViewController?
    var presentationType: PresentationType?
    
    var tabBar: IMTabBarController
    
    // Coordinators
    
    private var homeCoordinator: HomeCoordinator
    private var favoritesCoordinator: FavoritesCoordinator!
    private var configCoordinator: ConfigCoordinator!
    
    // Views
    
    required init(window: UIWindow) {
        self.window = window
        
        homeCoordinator = HomeCoordinator()
        favoritesCoordinator = FavoritesCoordinator()
        configCoordinator = ConfigCoordinator()
        
        tabBar = IMTabBarController()
    }
    
    func start() {
        tabBar.viewControllers = [
            homeCoordinator.start(),
            favoritesCoordinator.start(),
            configCoordinator.start()
        ]
        window.rootViewController = tabBar
    }
    
    func stop() {
        view = nil
        navigation = nil
        presentationType = nil
    }
    
    func selectTabBar(_ section: IMTabBarController.TabBarSections) {
        tabBar.select(section: section)
    }
}
