//
//  APINetwork.swift
//  HEPDemo
//
//  Created by Newton Foundation on 2019/6/20.
//  Copyright © 2019 Newton Foundation. All rights reserved.
//

import Foundation

enum APIService {
    case getAuthProof(params: [String: String])
    case getAuthLogin(params: [String: String])
    case getAuthPay(params: [String: String])
    case signMessage(params: [String: String])
    case signTransaction(params: [String: String])
    
    var baseURL: URL {
        return Config().apiBaseURL
    }
    
    var path: String {
        switch self {
        case .getAuthLogin:
            return "get/client/login/"
        case .getAuthPay:
            return "get/client/pay/"
        case .getAuthProof:
            return "get/client/proof/"
        case .signMessage:
            return "get/client/sign/message/"
        case .signTransaction:
            return "get/client/sign/transaction/"
        }
    }
    
    var method: String {
        switch self {
        case .getAuthLogin:
            return "post"
        case .getAuthPay:
            return "post"
        case .getAuthProof:
            return "post"
        case .signMessage:
            return "post"
        case .signTransaction:
            return "post"
        }
    }
    
    var params: [String: String] {
        switch self {
        case .getAuthLogin(let params):
            return params
        case .getAuthPay(let params):
            return params
        case .getAuthProof(let params):
            return params
        case .signMessage(let params):
            return params
        case .signTransaction(let params):
            return params
        }
    }
}




class APINetwork {
    
    func sendRequest(service: APIService, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 60.0
        let session = URLSession(configuration: sessionConfig)
        var request = URLRequest(url: service.baseURL.appendingPathComponent(service.path))
        request.httpMethod = service.method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: service.params, options: []) else {
            return
        }
        request.httpBody = httpBody
        let task = session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }
        task.resume()
    }
    
    func getAuthLogin(params: [String: String], completion: @escaping (HEPAuthInfoModel) -> Void, failure: @escaping () -> Void) {
        self.sendRequest(service: .getAuthLogin(params: params), completion: { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                if let data = data {
                    do {
                        let dic = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                        
                        let model = try JSONDecoder().decode(HEPAuthInfoModel.self, from: JSONSerialization.data(withJSONObject: dic?.value(forKey: "result")))
                        completion(model)
                    } catch {
                        failure()
                    }
                } else {
                    failure()
                }
            } else {
                failure()
            }
        })
    }
    
    func getAuthPay(params: [String: String], completion: @escaping (HEPPayInfoModel) -> Void, failure: @escaping () -> Void) {
        self.sendRequest(service: .getAuthPay(params: params), completion: { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                if let jsonData = data {
                    do {
                        let dic = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? NSDictionary
                        
                        let model = try JSONDecoder().decode(HEPPayInfoModel.self, from: JSONSerialization.data(withJSONObject: dic?.value(forKey: "result")))
                        completion(model)
                    } catch {
                        failure()
                    }
                } else {
                    failure()
                }
            } else {
                failure()
            }
        })
    }
    
    func getAuthProof(params: [String: String], completion: @escaping (HEPProofsModel) -> Void, failure: @escaping () -> Void) {
        self.sendRequest(service: .getAuthProof(params: params), completion: { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                if let jsonData = data {
                    do {
                        let dic = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? NSDictionary
                        
                        let model = try JSONDecoder().decode(HEPProofsModel.self, from: JSONSerialization.data(withJSONObject: dic?.value(forKey: "result")))
                        completion(model)
                    } catch {
                        failure()
                    }
                } else {
                    failure()
                }
            } else {
                failure()
            }
        })
    }

    func getSignMessage(params: [String: String], completion: @escaping (HEPSignMsgModel) -> Void, failure: @escaping () -> Void) {
        self.sendRequest(service: .signMessage(params: params), completion: { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                if let jsonData = data {
                    do {
                        let dic = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? NSDictionary
                        
                        let model = try JSONDecoder().decode(HEPSignMsgModel.self, from: JSONSerialization.data(withJSONObject: dic?.value(forKey: "result")))
                        completion(model)
                    } catch {
                        failure()
                    }
                } else {
                    failure()
                }
            } else {
                failure()
            }
        })
    }
    
    func getSignTransaction(params: [String: String], completion: @escaping (HEPSignTransModel) -> Void, failure: @escaping () -> Void) {
        self.sendRequest(service: .signTransaction(params: params), completion: { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                if let jsonData = data {
                    do {
                        let dic = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? NSDictionary
                        
                        let model = try JSONDecoder().decode(HEPSignTransModel.self, from: JSONSerialization.data(withJSONObject: dic?.value(forKey: "result")))
                        completion(model)
                    } catch {
                        failure()
                    }
                } else {
                    failure()
                }
            } else {
                failure()
            }
        })
    }
}


