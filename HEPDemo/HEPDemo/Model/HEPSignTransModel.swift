//
//  HEPSignTransModel.swift
//  HEPDemo
//
//  Created by Heng Yiwei on 2020/3/9.
//  Copyright © 2020 Yiwei Heng. All rights reserved.
//

import Foundation

struct HEPSignTransModel: Codable {
    
    var dappID: String
    var protocolName: String
    var protocolVersion: String
    var ts: String
    var nonce: String
    var signType: String
    var signature: String
    var action: String
    var amount: String
    var from: String
    var to: String
    var gasPrice: String
    var gasLimit: String
    var data: String
    var transactionCount: String
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
        case amount = "amount"
        case from = "from"
        case to = "to"
        case gasPrice = "gas_price"
        case gasLimit = "gas_limit"
        case data = "data"
        case transactionCount = "transaction_count"
        case uuid = "uuid"
    }
}
