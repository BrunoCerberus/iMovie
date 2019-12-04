//
//  UITabBarController+Utils.swift
//  iMovie
//
//  Created by bruno on 04/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit

extension UITabBarController {
    func setTabBarVisible(visible: Bool, duration: TimeInterval, animated: Bool) {
        if tabBarIsVisible() == visible { return }
        let frame = self.tabBar.frame
        let height = frame.size.height
        let offsetY = (visible ? -height : height)

        // animation
        
        UIViewPropertyAnimator(duration: duration, curve: .linear) {
            _ = self.tabBar.frame.offsetBy(dx: 0, dy: offsetY)
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height + offsetY)
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
            }.startAnimation()
    }

    func tabBarIsVisible() -> Bool {
        return self.tabBar.frame.origin.y < UIScreen.main.bounds.height
    }
    
    func setTabBarSeparator(bottonSpace: CGFloat? = 0, topSpace: CGFloat? = 0) {
        if let items = self.tabBar.items {
            
            //Get the height of the tab bar
            
            let height = self.tabBar.bounds.height
            
            //Calculate the size of the items
            
            let numItems = items.count
            let itemSize = CGSize(width: tabBar.frame.width / CGFloat(numItems),
                                  height: tabBar.frame.height)
            
            for index in 1...numItems {
                    let xPosition = itemSize.width * CGFloat(index)
                    let space = bottonSpace! + topSpace!
                    let frame = CGRect(x: xPosition, y: bottonSpace!,
                                       width: 0.5, height: height - space)
                    let separator = UIView(frame: frame)
                    separator.backgroundColor = UIColor.darkGray
                    tabBar.insertSubview(separator, at: 1)
            }
        }
    }
}
