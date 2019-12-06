//
//  IMTabBarController.swift
//  iMovie
//
//  Created by bruno on 05/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit

class IMTabBarController: TabBarController {
    enum TabBarSections: Int {
        case home
        case favorites
        case configuration
    }
    
    func select(section: TabBarSections) {
        selectedIndex = section.rawValue
        
        if let controller = UIApplication.shared.topViewController() {
            NotificationCenter.default.post(name: .tabBarDidSelect,
                                            object: nil,
                                            userInfo: [controllerKey: controller])
        }
    }
}
