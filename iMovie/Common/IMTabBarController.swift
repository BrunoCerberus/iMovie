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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
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

extension IMTabBarController {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        guard let fromView = selectedViewController?.view, let toView = viewController.view else { return false }
//
//        if fromView != toView {
//          UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
//        }

        return true
    }
}
