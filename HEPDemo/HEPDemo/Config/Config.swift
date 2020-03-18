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
            return URL(string: "http://47.240.113.82:9999/")!
        }
    }
    
    var bundleSource: String {
        switch currentServer{
        case .mainnet:
            return ""
        case .testnet:
            return "hep-demo-testnet"
        case .betanet:
            return ""
        case .devnet:
            return "org.newtonproject.HEPDemo.dev"
        }
    }
    
    var schemeProtocol: String {
        switch currentServer{
        case .mainnet:
            return ""
        case .testnet:
            return "hep-demo-testnet"
        case .betanet:
            return ""
        case .devnet:
            return "hep-demo-dev"
        }
    }
    
    var environment: Int {
        switch currentServer{
        case .mainnet:
            return 1
        case .testnet:
            return 2
        case .betanet:
            return 2
        case .devnet:
            return 3
        }
    }
}
