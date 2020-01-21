//
//  UIColor+Utils.swift
//  iMovie
//
//  Created by bruno on 04/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit

extension UIColor {
    
    public static let imBackgroundComponent = UIColor(hex6: 0x26272C)
    public static let imNavigationColor = UIColor(hex6: 0xF7CE5B)

    // MARK: - Initializer
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(fromHex: Int) {
        self.init(red: (fromHex >> 16) & 0xff, green: (fromHex >> 8) & 0xff, blue: fromHex & 0xff)
    }
    
    convenience init?(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines).remove(["#"])
        guard let hexNumber = UInt32(hexString, radix: 16) else {
            return nil
        }
        self.init(hex6: hexNumber)
    }
    
    /**
     The shorthand four-digit hexadecimal representation of color with alpha.
     #RGBA defines to the color #RRGGBBAA.
     
     - parameter hex4: Four-digit hexadecimal value.
     */
    public convenience init(hex4: UInt16) {
        let divisor = CGFloat(15)
        let red = CGFloat((hex4 & 0xF000) >> 12) / divisor
        let green = CGFloat((hex4 & 0x0F00) >> 8) / divisor
        let blue = CGFloat((hex4 & 0x00F0) >> 4) / divisor
        let alpha = CGFloat(hex4 & 0x000F) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The six-digit hexadecimal representation of color of the form #RRGGBB.
     
     - parameter hex6: Six-digit hexadecimal value.
     */
    public convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green = CGFloat((hex6 & 0x00FF00) >> 8) / divisor
        let blue = CGFloat(hex6 & 0x0000FF) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // MARK: - String
    /// String representation of the hexadecimal string: RRGGBB
    var hexString: String? {
        if let components = self.cgColor.components {
            if components.count == 2 {
                let white = components[0]
                return  String(format: "%02X%02X%02X", (Int)(white * 255), (Int)(white * 255), (Int)(white * 255))
            }
            if components.count >= 3 {
                let r = components[0]
                let g = components[1]
                let b = components[2]
                return  String(format: "%02X%02X%02X", (Int)(r * 255), (Int)(g * 255), (Int)(b * 255))
            }
            return nil
        }
        return nil
    }
    
    /// String representation in the format #RRGGBB
    var photoshopString: String {
        return "#\(hexString ?? "000000")"
    }
}
