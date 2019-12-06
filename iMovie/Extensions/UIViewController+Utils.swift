//
//  UIViewController+Utils.swift
//  iMovie
//
//  Created by bruno on 05/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit

extension UIViewController {
    
    @objc func dismissAnimated() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupDismissLeftBarButtonItem(image: UIImage? = nil) {
        let closeBarButtonItem = UIBarButtonItem(
            image: image != nil ? image : #imageLiteral(resourceName: "BTN_CLOSE_WHITE").withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(self.dismissAnimated)
        )
        navigationItem.leftBarButtonItem = closeBarButtonItem
    }
    
    func setupLeftCloseBarButtonItem() {
        let img = UIImage(named: "BTN_VOLTAR")
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: img,
                                                           landscapeImagePhone: img,
                                                           style: .plain,
                                                           target: self.navigationController,
                                                           action: #selector(self.dismissAnimated))
    }
    
    func navigationPopToRoot() {
        let img = UIImage(named: "BTN_VOLTAR")
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: img,
                                                           landscapeImagePhone: img,
                                                           style: .plain,
                                                           target: self.navigationController,
                                                           action: #selector(navigationController?.popToRootViewController(animated:)))
    }
    
    func defaultBackButton() {
        let img = UIImage(named: "BTN_VOLTAR")
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: img,
                                                           landscapeImagePhone: img,
                                                           style: .plain,
                                                           target: self.navigationController,
                                                           action: #selector(navigationController?.popViewController(animated:)))
    }
    
    /// Executes a block of code on the main thread
    func onUIThread(code: @escaping () -> Void) {
        DispatchQueue.main.async {
            code()
        }
    }
    
}
