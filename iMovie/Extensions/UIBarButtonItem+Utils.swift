//
//  UIBarButtonItem+Utils.swift
//  iMovie
//
//  Created by bruno on 05/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    private static var tappedAction: (() -> Void)?
    
    class func createCloseButton(withImage image: UIImage, andAction action: @escaping (() -> Void) ) -> UIBarButtonItem {
        self.tappedAction = action
        return UIBarButtonItem(image: image,
                               style: .plain,
                               target: self,
                               action: #selector(UIBarButtonItem.actionButton))
    }
    
    @objc class private func actionButton() {
        self.tappedAction!()
    }
}
