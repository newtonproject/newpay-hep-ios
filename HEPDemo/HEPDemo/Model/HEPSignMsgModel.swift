//
//  HEPSignMsgModel.swift
//  HEPDemo
//
//  Created by Heng Yiwei on 2020/3/9.
//  Copyright © 2020 Yiwei Heng. All rights reserved.
//

import Foundation

struct HEPSignMsgModel: Codable {
    
    var dappID: String
    var protocolName: String
    var protocolVersion: String
    var ts: String
    var nonce: String
    var signType: String
    var signature: String
    var action: String
    var message: String
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
        case message = "message"
        case uuid = "uuid"
    }
}
