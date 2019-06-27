//
//  Config.swift
//  HEPDemo
//
//  Created by Newton Foundation on 2019/6/20.
//  Copyright © 2019 Newton Foundation. All rights reserved.
//

import Foundation

enum RPCServer {
    case mainnet
    case testnet
    case betanet
    case devnet
}

struct Config {
    
    let currentServer = RPCServer.devnet
    
    var apiBaseURL: URL {
        switch currentServer{
        case .mainnet:
            return URL(string: "http://47.52.170.176:9999")!
        case .testnet:
            return URL(string: "http://47.52.170.176:9999")!
        case .betanet:
            return URL(string: "http://47.52.170.176:9999")!
        case .devnet:
            return URL(string: "http://47.52.170.176:9999")!
        }
    }
    
}
