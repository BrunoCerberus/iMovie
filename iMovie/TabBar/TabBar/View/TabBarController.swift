//
//  TabBarController.swift
//  iMovie
//
//  Created by bruno on 05/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import Foundation
import UIKit

private enum NotificationNames: String {
    case tabBarDidSelect
}

extension Notification.Name {
    static let tabBarDidSelect = Notification.Name(NotificationNames.tabBarDidSelect.rawValue)
}

class TabBarController: UITabBarController {
    
    // MARK: - Properties
    let controllerKey = "viewController"
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Internal Methods
    func setup() {
        tabBar.tintColor = .imYellow
        tabBar.backgroundColor = .white
        edgesForExtendedLayout = []
        extendedLayoutIncludesOpaqueBars = false
        tabBar.isTranslucent = false
        delegate = self
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        NotificationCenter.default.post(name: .tabBarDidSelect,
                                        object: nil,
                                        userInfo: [controllerKey: viewController])
        viewController.dismiss(animated: false, completion: nil)
        guard let navigation = (viewController as? UINavigationController) else { return }
        navigation.popToViewController(navigation.viewControllers[0], animated: false)
    }
}
