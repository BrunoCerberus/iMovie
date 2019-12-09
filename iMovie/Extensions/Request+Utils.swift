//
//  Request+Utils.swift
//  iMovie
//
//  Created by bruno on 09/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import Foundation
import Alamofire

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
        debugPrint("=============REQUEST BODY==============")
        debugPrint(self)
        debugPrint("=======================================")
        #endif
        return self
    }
}
