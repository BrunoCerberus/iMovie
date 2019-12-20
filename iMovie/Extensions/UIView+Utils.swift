//
//  UIView+Utils.swift
//  iMovie
//
//  Created by bruno on 04/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import Foundation
import UIKit

let kErrorDequeueCellIdenfier = "Could not dequeue cell with identifier"

public extension UIView {
    static var identifier: String { return String(describing: self) }
    
    static func fromNib<T: UIView>(owner: Any? = nil) -> T {
        guard let result = Bundle.main.loadNibNamed(T.identifier, owner: owner, options: nil)?.first as? T else {
            fatalError("\(kErrorDequeueCellIdenfier): \(T.identifier)")
        }
        return result
    }
    
    static func startSelectionFeedback() {
        let selection = UISelectionFeedbackGenerator()
        selection.selectionChanged()
    }
    
    func showHUD() {
           PKHUD.sharedHUD.dimsBackground = true
           let activity = NVActivityIndicatorView(frame: CGRect(x: 1, y: 1, width: 50, height: 50),
                                                  type: .ballClipRotateWithoutScale,
                                                  color: UIColor(fromHex: 0x64C346),
                                                  padding: 0.0 )
           activity.startAnimating()
           activity.clipsToBounds = false
           PKHUD.sharedHUD.contentView = activity
           DispatchQueue.main.async {
               PKHUD.sharedHUD.show()
           }
       }
       
       func hideHUD() {
           DispatchQueue.main.async {
               PKHUD.sharedHUD.hide()
           }
       }
       
       func hideHUD(animated: Bool, completion: @escaping () -> Void) {
           PKHUD.sharedHUD.hide(animated) { (_) in
               completion()
           }
       }
}
