//
//  UINavigationController+Utils.swift
//  iMovie
//
//  Created by bruno on 04/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit

extension UINavigationController {
    func popTo<T: UIViewController>(viewController: T.Type, executeBeforePop: ((T) -> Void) = { _ in }) {
        viewControllers.forEach { (viewC) in
            if viewC.isKind(of: viewController.self) {
                if let typedViewController = viewC as? T {
                    executeBeforePop(typedViewController)
                    popToViewController(viewC, animated: true)
                }
            }
        }
    }
}
