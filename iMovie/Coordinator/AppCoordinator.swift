//
//  AppCoordinator.swift
//  iMovie
//
//  Created by bruno on 05/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    var window: UIWindow
    var foregroundWindow: UIWindow
    
    var view: TabBarController?
    var navigation: IMNavigationViewController?
    var presentationType: PresentationType?
    
    var tabBarCoordinator: TabBarCoordinator?
    
    func start() {
        tabBarCoordinator = TabBarCoordinator(window: self.window)
        tabBarCoordinator?.delegate = self
        tabBarCoordinator?.start()
    }
    
    func stop() {
        view = nil
        navigation = nil
        presentationType = nil
    }
    
    required init(window: UIWindow) {
        self.window = window
        self.window.backgroundColor = .imBackgroundComponent
        self.window.makeKeyAndVisible()
        self.foregroundWindow = UIWindow(frame: UIScreen.main.bounds)
    }
}

extension AppCoordinator: TabBarCoordinatorDelegate {
    func tabBarCoordinatorDidFinish(tabBarCoordinator: TabBarCoordinator) {
        
    }
}
