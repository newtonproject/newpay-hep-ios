//
//  HEPAuthInfoModel.swift
//  HEPDemo
//
//  Created by Newton Foundation on 2019/6/20.
//  Copyright © 2019 Newton Foundation. All rights reserved.
//

import Foundation

struct HEPAuthInfoModel: Codable {
    var dappID: String
    var protocolName: String
    var protocolVersion: String
    var ts: Int64
    var nonce: String
    var signType: String
    var signature: String
    var action: String
    var scope: Int64
    var memo: String
    var uuid: String
    
    enum CodingKeys: String, CodingKey {
        case dappID = "dapp_id"
        case protocolName = "protocol"
        case protocolVersion = "version"
        case ts = "ts"
        case nonce = "nonce"
        case signType = "sign_type"
        case signature = "signature"
        case action = "action"
        case scope = "scope"
        case memo = "memo"
        case uuid = "uuid"
    }
}
