//
//  UIApplication+Utils.swift
//  iMovie
//
//  Created by bruno on 04/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit

extension UIApplication {
    var rootController: UIViewController? {
        return UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
    }
    
    func openAppSettings() {
        let url = URL(staticString: UIApplication.openSettingsURLString)
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    static func openUrlOnSafari(_ url: String) {
        let url = URL(staticString: url)
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    /// Use to find the top view controller
    /// - Parameter controller: The root view controller
    func topViewController(controller: UIViewController? = UIApplication.shared.rootController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
