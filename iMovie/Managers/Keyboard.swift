//
//  Keyboard.swift
//  iMovie
//
//  Created by bruno on 04/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift

struct KeyboardConfig {
    static func start() {
        // Keyboard handler
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "OK"
        IQKeyboardManager.shared.shouldResignOnTouchOutside   = true
        IQKeyboardManager.shared.enable                       = true
    }
}
