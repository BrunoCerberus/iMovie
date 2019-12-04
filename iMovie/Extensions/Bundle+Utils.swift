//
//  Bundle+Utils.swift
//  iMovie
//
//  Created by bruno on 04/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    var urlTypeScheme: String {
        guard let scheme = infoDictionary?["UrlTypeScheme"] as? String else {
            fatalError("UrlTypeScheme must exist to handle universal link")
        }
        
        return scheme
    }
}
