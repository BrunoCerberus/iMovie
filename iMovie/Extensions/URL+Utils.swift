//
//  URL+Utils.swift
//  iMovie
//
//  Created by bruno on 04/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import Foundation

extension URL {
    init(staticString: String) {
        guard let url = URL(string: staticString) else {
            preconditionFailure("Invalid static URL string: \(staticString)")
        }
        self = url
    }
}
