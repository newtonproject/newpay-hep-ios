//
//  NewtonSDK.swift
//  NewtonSDKDemo
//
//  Created by newton on 2019/2/15.
//  Copyright © 2019年 newton. All rights reserved.
//

import Foundation
import UIKit

open class NewtonSDK: NSObject {
    
    /**
     Public parameters for NewtonSDK
     
     - Parameters:
     - app_id: (String) App ID, uuid string
     - message: (String) place order: order json // login: Timestamp + Nonce
     - sign_r: (String) The r part of signature (dapp_sign_r)
     - sign_s: (String) The s part of signature (dapp_sign_s)
     - protocol_version: (Int) The version of protocol, default is 1
     - bundle_source: (String) Android's package name, iOS's bundle ID
     - environment: (Int) 1 for release, 2 for testnet, 3 for dev
     - schemaProtocol: (String) For example newmal-dev
     */
    
    let appId: String
    let protocolVersion: Int
    let bundleSource: String
    let environment: Int
    let schemaProtocol: String
    
    @objc public init(
        appId: String,
        protocolVersion: Int,
        bundleSource: String,
        environment: Int,
        schemaProtocol: String
        ) {
        
        self.appId = appId
        self.protocolVersion = protocolVersion
        self.bundleSource = bundleSource
        self.environment = environment
        self.schemaProtocol = schemaProtocol
        
        super.init()
        
        print("Did init")

    }
    
    
    /**
     requestProfile: Request Profile for Login
     
     - Parameters:
        - Public parameters
        - scope: (Int) 1 for basic profile, ...
        - message: Timestamp + Nonce
     */
    @objc open func requestProfile (
        
        message: String,
        sign_r: String,
        sign_s: String,
        scope: Int = 1,
        completion: @escaping (String) -> Void,
        failure: @escaping (String) -> Void
        )
    {
        if validateParams(checkList: [self.appId, message, sign_r, sign_s, String(self.protocolVersion), self.bundleSource, String(environment), String(scope)]) {
            
            var params = [String: String]()
            params[Constants.METHOD] = Constants.REQUEST_PROFILE
            params[Constants.SCHEMA_PROTOCOL] = self.schemaProtocol
            params[Constants.APPID] = self.appId
            params[Constants.MESSAGE] = message
            params[Constants.SIGN_R] = sign_r
            params[Constants.SIGN_S] = sign_s
            params[Constants.PROTOCOL_VERSION] = String(self.protocolVersion)
            params[Constants.BUNDLE_SOURCE] = self.bundleSource
            params[Constants.ENVIRONMENT] = String(environment)
            params[Constants.SCOPE] = String(scope)
            
            jumpToNewpay(with: params)
            
            completion("Success")
        } else {
            failure("Failed")
        }
        
    }
    
    /**
     placeOrder: Place order onto NewChain
     
     - Parameters:
        - Public parameters
        - orderJson: (String) url.encode(orders)
        - message: order json
     
     orders: [order]
     
     order:
     
     - Parameters:
     - order_number: (String)
     - price: (String)
     - currency: (String)
     - buyer_newid: (String)
     - seller_newid: (String)
     */
    @objc open func placeOrder (
        message: String,
        sign_r: String,
        sign_s: String,
        orderJson: String,
        completion: @escaping (String) -> Void,
        failure: @escaping (String) -> Void
        )
    {
        print("Did get order")
        if validateParams(checkList: [self.appId, message, sign_r, sign_s, String(self.protocolVersion), self.bundleSource, String(environment), orderJson]) {
            
            var params = [String: String]()
            params[Constants.METHOD] = Constants.PLACE_ORDER
            params[Constants.SCHEMA_PROTOCOL] = self.schemaProtocol
            params[Constants.APPID] = self.appId
            params[Constants.MESSAGE] = message
            params[Constants.SIGN_R] = sign_r
            params[Constants.SIGN_S] = sign_s
            params[Constants.PROTOCOL_VERSION] = String(self.protocolVersion)
            params[Constants.BUNDLE_SOURCE] = self.bundleSource
            params[Constants.ENVIRONMENT] = String(environment)
            params[Constants.ORDER_JSON] = orderJson
            
            jumpToNewpay(with: params)
            
            
            completion("Success")
        } else {
            failure("Failed")
        }
        
    }
    
    
    
    /**
     pay: Make payment using Newpay
     
     - Parameters:
     - Public parameters
     - symbol: (String) "NEW", "BTC", etc
     - address: (String) Target address
     - amount: (String) pay amount
     - bundle_source: (String) Android's package name, iOS's bundle ID
     - summary: (String) Description for the payment
     */
    private func pay (
        message: String,
        sign_r: String,
        sign_s: String,
        symbol: String,
        address: String,
        amount: String,
        summary: String,
        completion: @escaping (String) -> Void,
        failure: @escaping (String) -> Void
        )
    {
        if validateParams(checkList: [self.appId, message, sign_r, sign_s, String(self.protocolVersion), self.bundleSource, String(environment), symbol, address, amount, summary]) {
            
            var params = [String: String]()
            params[Constants.METHOD] = Constants.PAY
            params[Constants.SCHEMA_PROTOCOL] = self.schemaProtocol
            params[Constants.APPID] = self.appId
            params[Constants.MESSAGE] = message
            params[Constants.SIGN_R] = sign_r
            params[Constants.SIGN_S] = sign_s
            params[Constants.PROTOCOL_VERSION] = String(self.protocolVersion)
            params[Constants.BUNDLE_SOURCE] = self.bundleSource
            params[Constants.ENVIRONMENT] = String(environment)
            params[Constants.SYMBOL] = symbol
            params[Constants.ADDRESS] = address
            params[Constants.AMOUNT] = amount
            params[Constants.SUMMARY] = summary
            
            jumpToNewpay(with: params)
            
            completion("Success")
        } else {
            failure("Failed")
        }
    }
    
    
    
    /**
     URL Schema
     
     [protocol]://[host]?[parameters]
     
     - Protocol:
     - newpay: Release environment
     - newpay-dev: Dev environment
     - newpay-test: Test environment
     
     - Host:
     - sdk: Identifier for NewtonSDK
     
     - Parameters:
     - Public parameters
     - method: (String) Name of function from NewtonSDK that is called by third party app
     - schema_protocol: Third party app schema
     - Special parameters: based on functions
     */
    private func generateURLSchema (params: [String: String]) -> String {
        let schema_protocol: String = {
            switch Int(params[Constants.ENVIRONMENT]!)  {
            case 1: return Constants.NEWPAY
            case 2: return Constants.NEWPAY_TEST
            case 3: return Constants.NEWPAY_DEV
            default:
                return Constants.NEWPAY
            }}()
        
        let paramStr = formatParams(with: params)
        
        return "\(schema_protocol)://sdk?\(paramStr)"
    }
    
    
    /**
     formatParams
     
     */
    private func formatParams(with params: [String: String]) -> String {
        var str = ""
        for (key, value) in params {
            str += "\(key)=\(value)&"
        }
        return String(str.dropLast())
    }
    
    
    
    /**
     validateParams
     
     - Parameters:
     - checkList: List of parameter values
     
     - Description:
     - Check if any parameter value is empty
     */
    private func validateParams (checkList: [String]) -> Bool {
        // Check if parameters are empty
        for content in checkList {
            if content == "" {
                return false
            }
        }
        return true
    }
    
    
    
    /**
     jumpToNewpay
     
     - Parameters:
     - params: Parameters to pass to Newpay
     
     - Description:
     - Format url schema with params and jump to Newpay
     */
    func jumpToNewpay(with params: [String: String]) {
        print("Did jump")
        let urlString = generateURLSchema(params: params)
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: encodedString!)
        UIApplication.shared.openURL(url!)
    }
    
}



