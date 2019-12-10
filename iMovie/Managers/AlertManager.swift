//
//  AlertManager.swift
//  iMovie
//
//  Created by bruno on 04/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit
import SwiftMessages

class AlertManager {
    private var alertView: MessageView?
    private var toastAlertType: ToastAlertType?
    private var toastPresentationType: SwiftMessages.PresentationStyle?
    private var alertController: UIAlertController?
    private var alertType: AlertType
    private var title: String?
    private var message: String?
    private var buttonTitle: String?
    private var blockText: String?
    
    /// Alert types
    ///
    /// - toast: For toast alert selection
    /// - modal: For modal alert selection
    enum AlertType {
        case toast
        case normal
        case confirm
        case customConfirm(dismissActionTitle: String, confirmActionTitle: String)
        case block
        case custom(_ buttonTitle: String)
    }
    
    /// Toast Alert types to choose layout definition
    ///
    /// - success: When success needs to be displayed
    /// - info: When info needs to be displayed
    /// - error: When error needs to be displayed
    enum ToastAlertType {
        case success
        case error
        case black
    }
    
    /// Initializer for toast
    ///
    /// - Parameters:
    ///   - toastType: What kind of toast based on ToastAlertType
    ///   - title: The alert title
    ///   - message: The message
    init(with toastType: ToastAlertType,
         title: String,
         message: String,
         backgroundColor: UIColor? = nil,
         foregroundColor: UIColor = .white,
         showIconImage: Bool = true,
         presentationStyle: SwiftMessages.PresentationStyle? = nil) {
        alertType              = .toast
        toastAlertType         = toastType
        toastPresentationType  = presentationStyle
        self.title             = title
        self.message           = message
        alertView              = MessageView.viewFromNib(layout: .cardView)
        //add parameter accessibilityIdentifier for authentized tests
        alertView?.accessibilityIdentifier = "Alert_View"
        createToastAlert(backgroundColor: backgroundColor, foregroundColor: foregroundColor, showIconImage: showIconImage)
    }
    
    /// An optional button tap handler. The `button` is automatically
    /// configured to call this tap handler on `.TouchUpInside`.
    open var buttonTapHandler: ((_ button: UIButton) -> Void)?
    
    /// Initializer for toast
    ///
    /// - Parameters:
    ///   - toastType: What kind of toast based on ToastAlertType
    ///   - title: The alert title
    ///   - message: The message
    ///   - buttonTitle: The message
    ///   - buttonTapHandler: Action Button Tap Handler
    init(with toastType: ToastAlertType,
         title: String, message: String,
         buttonTitle: String,
         presentationStyle: SwiftMessages.PresentationStyle? = nil,
         buttonTapHandler: ((_ button: UIButton) -> Void)?) {
        alertType              = .toast
        toastAlertType         = toastType
        toastPresentationType  = presentationStyle
        self.title             = title
        self.message           = message
        self.buttonTitle       = buttonTitle
        alertView              = MessageView.viewFromNib(layout: .cardView)
        self.buttonTapHandler = buttonTapHandler
        //add parameter accessibilityIdentifier for authentized tests
        alertView?.accessibilityIdentifier = "Alert_View"
        createToastAlert(buttonTitle: buttonTitle)
    }

    private func showAlertController() {
        guard let alertController = alertController, let window = UIApplication.shared.delegate?.window else {
            return
        }
        window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }

    /// Display the alert in the current context
    ///
    /// - Parameter completion: Completion handler for
    func show(_ completion: (() -> Void)? = nil) {

        switch alertType {
        case .toast:
            self.alertView?.accessibilityIdentifier = "alertMessage"
            self.alertView?.isAccessibilityElement = true
            var config = SwiftMessages.defaultConfig
            
            if let presentationType = toastPresentationType {
                config.presentationStyle = presentationType
            }
            
            config.preferredStatusBarStyle = .lightContent
            config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
            config.eventListeners.append({ event in
                if case .didHide = event { completion?() }
            })
            
            DispatchQueue.main.async {
                SwiftMessages.show(config: config, view: self.alertView!)
            }

        case .normal:
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
                completion?()
            })
            alertController?.addAction(action)
            showAlertController()

        case .custom(let buttonTittle):
            let action = UIAlertAction(title: buttonTittle, style: .cancel, handler: { _ in
                completion?()
            })
            alertController?.addAction(action)
            showAlertController()

        case .confirm:
            let actionNo = UIAlertAction(title: "Não", style: .cancel, handler: nil)
            
            let actionYes = UIAlertAction(title: "Sim", style: .default) { (_) in
                completion?()
            }

            alertController?.addAction(actionNo)
            alertController?.addAction(actionYes)
            
            let window = UIApplication.shared.delegate?.window ?? UIWindow()
            var topViewController = window?.rootViewController
            
            while let presented = topViewController?.presentedViewController {
                topViewController = presented
            }
            
            topViewController?.present(alertController!, animated: true, completion: nil)
        case .customConfirm(let dismissActionTitle, let confirmActionTitle):
            let dismissAction = UIAlertAction(title: dismissActionTitle, style: .cancel, handler: nil)
            
            let confirmAction = UIAlertAction(title: confirmActionTitle, style: .default) { (_) in
                completion?()
            }
            
            alertController?.addAction(dismissAction)
            alertController?.addAction(confirmAction)
            
            let window = UIApplication.shared.delegate?.window ?? UIWindow()
            var topViewController = window?.rootViewController
            
            while let presented = topViewController?.presentedViewController {
                topViewController = presented
            }
            
            topViewController?.present(alertController!, animated: true, completion: nil)
        case .block:
            let actionNo = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            
            let actionYes = UIAlertAction(title: blockText, style: .default) { (_) in
                completion?()
            }
            
            alertController?.addAction(actionNo)
            alertController?.addAction(actionYes)
            
            let window = UIApplication.shared.delegate?.window ?? UIWindow()
            var topViewController = window?.rootViewController
            
            while let presented = topViewController?.presentedViewController {
                topViewController = presented
            }
            
            topViewController?.present(alertController!, animated: true, completion: nil)
        }
    }
    
    /// Dismiss the alert
    func dismiss() {
        alertController?.dismiss(animated: true, completion: nil)
    }
    
    private func createToastAlert(buttonTitle: String? = nil,
                                  backgroundColor: UIColor? = nil,
                                  foregroundColor: UIColor = .white,
                                  showIconImage: Bool = true) {
        switch toastAlertType! {
        case .success:
            alertView!.configureTheme(backgroundColor: backgroundColor ?? UIColor(fromHex: 0x58B349),
                                      foregroundColor: foregroundColor)
        case .error:
            alertView!.configureTheme(backgroundColor: backgroundColor ?? UIColor(fromHex: 0xDA3928),
                                      foregroundColor: foregroundColor)
            
        case .black:
            alertView!.configureTheme(backgroundColor: backgroundColor ?? UIColor(fromHex: 0x323232),
                                      foregroundColor: foregroundColor)
        }
        
        if buttonTitle != nil {
            alertView!.configureContent(title: self.title,
                                        body: self.message,
                                        iconImage: #imageLiteral(resourceName: "ICO_ALERT_WARNING"),
                                        iconText: nil,
                                        buttonImage: nil,
                                        buttonTitle: self.buttonTitle) { (button) in
                                            self.buttonTapHandler?(button)
            }
            alertView!.button?.isHidden = false
            alertView!.button?.layer.cornerRadius = 15
        } else {
            alertView!.configureContent(title: self.title!, body: self.message!)
            alertView!.button?.isHidden = true
        }
        //alertView?.accessibilityIdentifier = "alertView"
        alertView?.titleLabel?.accessibilityIdentifier = "alertTitle"
        alertView?.titleLabel?.isAccessibilityElement = true
        alertView?.bodyLabel?.accessibilityIdentifier = "alertBody"
        alertView?.bodyLabel?.isAccessibilityElement = true
    }
}
