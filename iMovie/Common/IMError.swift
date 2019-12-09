//
//  IMError.swift
//  iMovie
//
//  Created by bruno on 09/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import Foundation
    
struct IMError: Error {
    
    var title: String?
    var code: Int?
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    
    private var _description: String?
    
    init(title: String = "Verifique sua conexão com a internet e tente novamente",
         description: String? = nil, code: Int? = nil) {
        self.title = title
        self._description = description
        self.code = code
    }
}
