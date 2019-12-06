//
//  IMNavigationController.swift
//  iMovie
//
//  Created by bruno on 05/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit

class IMNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultNavigationStyle()
        self.tabBarItem.title                   = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func defaultNavigationStyle() {
        navigationBar.barTintColor              = UIColor.imNavigationColor
        navigationBar.tintColor                 = .black
        navigationBar.titleTextAttributes       = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationBar.isTranslucent             = false
        navigationBar.shadowImage               = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    convenience init(rootViewController: UIViewController, closeButton: Bool, closeButtonImage: UIImage = #imageLiteral(resourceName: "BTN_CLOSE_WHITE")) {
        self.init(rootViewController: rootViewController)
        if closeButton {
            let closeButtonItem = UIBarButtonItem(image: closeButtonImage,
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(IMNavigationViewController.close))
            rootViewController.navigationItem.leftBarButtonItem = closeButtonItem
        }
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    /**
     It adds the animation of navigation flow.
     
     - parameter type: CATransitionType, it means style of animation
     - parameter transitionSubtype: CATransitionSubtype, it means substyle of animation
     - parameter duration: CFTimeInterval, duration of animation
     */
    func addTransition(transitionType type: CATransitionType = .fade,
                       transitionSubtype: CATransitionSubtype? = nil,
                       duration: CFTimeInterval = 0.5) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = type
        transition.subtype = transitionSubtype
        self.view.window?.layer.add(transition, forKey: kCATransition)
    }
    
    /**
     It remove the animation of navigation flow.
     */
    func removeTransition() {
        self.view.window?.layer.removeAnimation(forKey: kCATransition)
    }
}
