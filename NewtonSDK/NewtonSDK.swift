//
//  NewtonSDK.swift
//  NewtonSDKDemo
//
//  Created by Newton on 2019/2/15.
//  Copyright 2018-2020 Newton Foundation. All rights reserved.
//

import Foundation
import UIKit

open class NewtonSDK: NSObject {
    
    
    /**
     *  Public parameters for NewtonSDK
     *
     * - dappId: (String) The decentralized application access key
     * - protocolVersion: (String) The version of protocol, default is 1.0
     * - protocolName: (String) The protocol name. default is "HEP".
     * - bundleSource: (String) Android's package name, iOS's bundle ID
     * - environment: (Int) Diffenrent environment for NewPay. 1 for release, 2 for testnet, 3 for dev
     * - schemaProtocol: (String) DApp schema
     */
    
    let dappId: String
    let protocolVersion: String
    let protocolName: String
    let bundleSource: String
    let environment: Int
    let schemaProtocol: String
    
    @objc public init(
        dappId: String,
        protocolVersion: String = "1.0",
        protocolName: String = "HEP",
        bundleSource: String,
        environment: Int,
        schemaProtocol: String
        ) {
        self.dappId = dappId
        self.protocolVersion = protocolVersion
        self.protocolName = protocolName
        self.bundleSource = bundleSource
        self.environment = environment
        self.schemaProtocol = schemaProtocol
        super.init()
        
        print("SDK did initialized")
    }
    
    
    /**
     *  requestProfile: Request Profile for Login
     *
     *  - Parameters:
     *  - Public parameters
     *  - memo: (String) Login Memo,optional
     *  - signature: (String) Signature hex string by DApp owner
     *  - signType: (String) Signature Type, by default is secp256r1
     *  - scope: (Int) 1 for basic profile without phone number, 2 for profile with more details
     *  - nonce: (String) Random string or auto-increment sequence
     *  - ts: (String) Timestamp
     *  - uuid: (String) uuid
     */
    
    @objc open func authLogin (
        
        memo: String,
        signature: String,
        signType: String = "secp256r1",
        scope: Int = 1,
        nonce: String,
        ts: String,
        uuid: String,
        completion: @escaping (String) -> Void,
        failure: @escaping (String) -> Void
        )
    {
        if validateParams(checkList: [self.dappId, memo, signature, String(self.protocolVersion), self.bundleSource, String(environment), String(scope)]) {
            
            var params = prepareBasicParams()
            
            params[Constants.ACTION] = Constants.AUTH_LOGIN
            params[Constants.SCOPE] = String(scope)
            params[Constants.MEMO] = memo
            params[Constants.SIGNATURE] = signature
            params[Constants.SIGN_TYPE] = signType
            params[Constants.TS] = ts
            params[Constants.NONCE] = nonce
            params[Constants.UUID] = uuid
            
            jumpToNewpay(with: params)
            
            completion("Succeed in passing parameters to NewPay")
        } else {
            failure("Fail to pass parameters to NewPay")
        }
        
    }
    
    
    /**
     *  placeOrder: Place order proof onto NewChain
     *
     *  - Parameters:
     *  - Public Parameters
     *
     *  - signature: (String) Signature hex string by DApp owner
     *  - signType: (String) Signature Type, by default is secp256r1
     *  - nonce: (String) Random string or auto-increment sequence
     *  - ts: (String) timestamp
     *  - proofHash: (String)The hash of proof which prefix is '0x'
     *  - uuid: (String) uuid
     *
     */
    
    @objc open func placeOrder (
        signature: String,
        signType: String = "secp256r1",
        proofHash: String,
        nonce: String,
        ts: String,
        uuid: String,
        completion: @escaping (String) -> Void,
        failure: @escaping (String) -> Void
        )
    {
        print("Did get order")
        if validateParams(checkList: [self.dappId, signature, String(self.protocolVersion), self.bundleSource, String(environment), proofHash]) {
            
            var params = prepareBasicParams()
            
            params[Constants.ACTION] = Constants.PROOF_SUBMIT
            params[Constants.PROOF_HASH] = proofHash
            params[Constants.SIGNATURE] = signature
            params[Constants.SIGN_TYPE] = signType
            params[Constants.TS] = ts
            params[Constants.NONCE] = nonce
            params[Constants.UUID] = uuid
            
            jumpToNewpay(with: params)
            
            completion("Succeed in passing parameters to NewPay")
        } else {
            failure("Fail to pass parameters to NewPay")
        }
        
    }
    
    
    /**
     *  Make payment using Newpay
     *
     *  - Parameters:
     *  - Public parameters
     *
     *  - signature: (String) Signature hex string by DApp owner
     *  - signType: (String) Signature Type, by default is secp256r1
     *  - description: (String) The order description
     *  - priceCurrency: (String) The symbol of fiat or digital token, such as USD, RMB, NEW,BTC,ETH.
     *  - totalPrice: (String) The amount of fiat or digital token, unit is the minimum unit of given fiat or digital token.
     *  - orderNumber: (String) The order number
     *  - seller: (String) The seller's NewID
     *  - customer: (String) The customer's NewID
     *  - broker: (String) The broker's NewID.
     *  - nonce: (String) Random string or auto-increment sequence
     *  - ts: (String) timestamp
     *  - uuid: (String) uuid
     */
    
    @objc open func pay (
        signature: String,
        signType: String = "secp256r1",
        description: String,
        priceCurrency: String,
        totalPrice: String,
        orderNumber: String,
        seller: String,
        customer: String,
        broker: String,
        nonce: String,
        ts: String,
        uuid: String,
        completion: @escaping (String) -> Void,
        failure: @escaping (String) -> Void
        )
    {
        if validateParams(checkList: [self.dappId, signature, signType,  String(self.protocolVersion), self.bundleSource, String(environment), description, priceCurrency, totalPrice, orderNumber, seller, customer, broker]) {
            
            var params = prepareBasicParams()
            
            params[Constants.ACTION] = Constants.PAY_ORDER
            params[Constants.SIGNATURE] = signature
            params[Constants.SIGN_TYPE] = signType
            params[Constants.DESCRIPTION] = description
            params[Constants.PRICE_CURRENCY] = priceCurrency
            params[Constants.TOTAL_PRICE] = totalPrice
            params[Constants.ORDER_NUMBER] = orderNumber
            params[Constants.SELLER] = seller
            params[Constants.CUSTOMER] = customer
            params[Constants.BROKER] = broker
            params[Constants.TS] = ts
            params[Constants.NONCE] = nonce
            params[Constants.UUID] = uuid
            
            jumpToNewpay(with: params)
            
            completion("Succeed in passing parameters to NewPay")
        } else {
            failure("Fail to pass parameters to NewPay")
        }
    }
    
    
    /**
     * Sign message using Newpay
     *
     *  - Parameters:
     *  - Public parameters
     *
     *  - signature: (String) Signature hex string by DApp owner
     *  - signType: (String) Signature Type, by default is secp256r1
     *  - message: (String) The message that needed to be signed
     *  - nonce: (String) Random string or auto-increment sequence
     *  - ts: (String) timestamp
     *  - uuid: (String) uuid
     */
    
    @objc open func signMessage (
        signature: String,
        signType: String = "secp256r1",
        message: String,
        nonce: String,
        ts: String,
        uuid: String,
        completion: @escaping (String) -> Void,
        failure: @escaping (String) -> Void
        )
    {
        if validateParams(checkList: [self.dappId, signature, signType,  String(self.protocolVersion), self.bundleSource, String(environment), message]) {
            
            var params = prepareBasicParams()
            
            params[Constants.ACTION] = Constants.SIGN_MESSAGE
            params[Constants.SIGNATURE] = signature
            params[Constants.SIGN_TYPE] = signType
            params[Constants.MESSAGE] = message
            params[Constants.TS] = ts
            params[Constants.NONCE] = nonce
            params[Constants.UUID] = uuid
            
            jumpToNewpay(with: params)
            
            completion("Succeed in passing parameters to NewPay")
        } else {
            failure("Fail to pass parameters to NewPay")
        }
    }
    
    
    /**
     * Sign transaction using Newpay
     *
     *  - Parameters:
     *  - Public parameters
     *
     *  - signature: (String) Signature hex string by DApp owner
     *  - signType: (String) Signature Type, by default is secp256r1
     *  - amount: (String) Amount in Transaction
     *  - from: (String) From address in Transaction, should be the same with the wallet address
     *  - to: (String) To address in Transaction
     *  - gasPrice: (String) Gas price in Transaction
     *  - gasLimit: (String) Gas limit in Transaction
     *  - data: (String) Data in Transaction
     *  - transactionCount: (String) Nonce in Transaction
     *  - nonce: (String) Random string or auto-increment sequence
     *  - ts: (String) Timestamp
     *  - uuid: (String) uuid
     */
    
    @objc open func signTransaction (
        signature: String,
        signType: String = "secp256r1",
        amount: String,
        from: String,
        to: String,
        nonce: String,
        gasPrice: String,
        gasLimit: String,
        data: String,
        transactionCount: String,
        ts: String,
        uuid: String,
        completion: @escaping (String) -> Void,
        failure: @escaping (String) -> Void
        )
    {
        if validateParams(checkList: [self.dappId, signature, signType,  String(self.protocolVersion), self.bundleSource, String(environment), amount, from, to, transactionCount, gasPrice, gasLimit, data]) {
            
            var params = prepareBasicParams()
            
            params[Constants.ACTION] = Constants.SIGN_TRANSACTION
            params[Constants.SIGNATURE] = signature
            params[Constants.SIGN_TYPE] = signType
            params[Constants.TS] = ts
            params[Constants.NONCE] = nonce
            params[Constants.UUID] = uuid
            params[Constants.AMOUNT] = amount
            params[Constants.FROM] = from
            params[Constants.TO] = to
            params[Constants.TRANSACTION_COUNT] = transactionCount
            params[Constants.GAS_PRICE] = gasPrice
            params[Constants.GAS_LIMIT] = gasLimit
            params[Constants.DATA] = data
            
            jumpToNewpay(with: params)
            
            completion("Succeed in passing parameters to NewPay")
        } else {
            failure("Fail to pass parameters to NewPay")
        }
    }
    
    
    /**
     *  URL Schema
     *
     *  [protocol]://[host]?[parameters]
     *
     *  - Protocol:
     *  - newpay: Release environment
     *  - newpay-dev: Dev environment
     *  - newpay-test: Test environment
     *
     *  - Host:
     *  - sdk: Identifier for NewtonSDK
     *
     *  - Parameters:
     *  - Public parameters
     *  - method: (String) Name of function from NewtonSDK that is called by third party app
     *  - schema_protocol: Third party app schema
     *  - Special parameters: based on functions
     *
     *  - Output:
     *  - newpay://sdk?schema_protocol=newpay&dappid=112345&protocol_version=1.0
     *
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
     *  Format parameters
     *  eg. schema_protocol=newpay&dappid=112345&protocol_version=1.0
     *
     */
    
    private func formatParams(with params: [String: String]) -> String {
        var str = ""
        for (key, value) in params {
            str += "\(key)=\(value)&"
        }
        return String(str.dropLast())
    }
    
    
    /**
     *  Prepare basic params
     *
     */
    
    private func prepareBasicParams() -> [String: String] {
        return [
            Constants.SCHEMA_PROTOCOL: self.schemaProtocol,
            Constants.DAPPID: self.dappId,
            Constants.PROTOCOL_VERSION: String(self.protocolVersion),
            Constants.PROTOCOL_NAME: self.protocolName,
            Constants.BUNDLE_SOURCE: self.bundleSource,
            Constants.ENVIRONMENT: String(environment)
        ]
    }
    
    
    /**
     *  Validate Params
     *
     *  - Parameters:
     *  - checkList: List of parameter values
     *  - Description:
     *  - Check if any parameter value is empty
     */
    
    private func validateParams (checkList: [String]) -> Bool {
        /// Check if parameters are empty
        for content in checkList {
            if content == "" {
                return false
            }
        }
        return true
    }
    
    
    /**
     *  jumpToNewpay
     *
     *  - Parameters:
     *  - params: Parameters to pass to Newpay
     *
     *  - Description:
     *  - Format url schema with params and jump to Newpay
     */
    
    private func jumpToNewpay(with params: [String: String]) {
        print("Did jump")
        let urlString = generateURLSchema(params: params)
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: encodedString!)
        UIApplication.shared.openURL(url!)
    }
}



