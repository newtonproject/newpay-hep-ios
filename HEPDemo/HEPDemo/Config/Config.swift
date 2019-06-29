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
    
    let currentServer = RPCServer.testnet
    
    var apiBaseURL: URL {
        switch currentServer{
        case .mainnet:
            return URL(string: "https://demo.hep.testnet.newtonproject.org/")!
        case .testnet:
            return URL(string: "https://demo.hep.testnet.newtonproject.org/")!
        case .betanet:
            return URL(string: "https://demo.hep.testnet.newtonproject.org/")!
        case .devnet:
            return URL(string: "https://demo.hep.testnet.newtonproject.org/")!
        }
    }
    
}
