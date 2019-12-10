//
//  Fetcher.swift
//  iMovie
//
//  Created by bruno on 09/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import Foundation
import Alamofire

public protocol Fetcher {
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: HTTPMethod { get }
    
    /// The task to be used in the request.
    var task: IMCodable? { get }
}
