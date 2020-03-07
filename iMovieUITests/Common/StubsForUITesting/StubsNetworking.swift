//
//  StubsNetworking.swift
//  iMovieUITests
//
//  Created by bruno on 07/03/20.
//  Copyright © 2019 bruno. All rights reserved.
//


import Foundation
import OHHTTPStubs

public class StubsNetworking {
    
    let prodDomain = "https://api.themoviedb.org/3/movie"
    
    func setup() {
        OHHTTPStubs.setEnabled(true)
        OHHTTPStubs.onStubActivation { (request: URLRequest, stub: OHHTTPStubsDescriptor, _: OHHTTPStubsResponse) in
            print("[OHHTTPStubs] Request to \(request.url!) has been stubbed with \(String(describing: stub))")
        }
    }
    
    func clear() {
        OHHTTPStubs.removeAllStubs()
    }
    
    func stubFor(_ path: String, and file: String, with status: Int32) {
        stub(condition: isHost(prodDomain) && isPath(path)) { _ in
            let stubPath = OHPathForFile(file, type(of: self))
            return fixture(filePath: stubPath!, status: status, headers: ["Content-Type": "application/json"])
        }
    }
}
