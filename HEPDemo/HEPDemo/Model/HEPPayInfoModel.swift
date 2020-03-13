//
//  HEPPayInfoModel.swift
//  HEPDemo
//
//  Created by Newton Foundation on 2019/6/20.
//  Copyright © 2019 Newton Foundation. All rights reserved.
//

import Foundation

struct HEPPayInfoModel: Codable {
    
    var dappID: String
    var protocolName: String /// protocol name. The default is "HEP".
    var protocolVersion: String /// protocol version. The example is "1.0".
    var ts: String /// timestamp
    var nonce: String
    var action: String
    
    var description: String /// The order description
    var priceCurrency: String /// symbol of fiat or digital token, such as USD, CNY, NEW,BTC,ETH
    var totalPrice: String
    var orderNumber: String
    var seller: String
    var customer: String
    var broker: String
    var signType: String /// Signature Type,aka cryptographic algorithm
    var signature: String /// signature hex string by DApp owner.
    var uuid: String
    
    enum CodingKeys: String, CodingKey {
        
        case dappID = "dapp_id"
        case protocolName = "protocol"
        case protocolVersion = "version"
        case action = "action"
        case description = "description"
        case priceCurrency = "price_currency"
        case totalPrice = "total_price"
        case orderNumber = "order_number"
        case seller = "seller"
        case customer = "customer"
        case broker = "broker"
        case ts = "ts"
        case nonce = "nonce"
        case signType = "sign_type"
        case signature = "signature"
        case uuid = "uuid"
    }
}
