//
//  HEPProofsModel.swift
//  HEPDemo
//
//  Created by Newton Foundation on 2019/6/20.
//  Copyright © 2019 Newton Foundation. All rights reserved.
//

import Foundation

struct HEPProofsModel: Codable {
    
    var dappID: String
    var protocolName: String /// protocol name. The default is "HEP".
    var protocolVersion: String /// protocol version. The example is "1.0".
    var ts: String /// timestamp
    var nonce: String
    var action: String
    var proof_hash: String
    var signature: String /// signature hex string by DApp owner.
    var signType: String /// Signature Type,aka cryptographic algorithm
    var uuid: String
    
    enum CodingKeys: String, CodingKey {
        case protocolVersion = "version"
        case protocolName = "protocol"
        case dappID = "dapp_id"
        case ts = "ts"
        case nonce = "nonce"
        case signType = "sign_type"
        case signature = "signature"
        case action = "action"
        case proof_hash = "proof_hash"
        case uuid = "uuid"
    }
}
