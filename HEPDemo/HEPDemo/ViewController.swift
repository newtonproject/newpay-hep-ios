//
//  ViewController.swift
//  HEPDemo
//
//  Created by Newton Foundation on 2019/6/18.
//  Copyright © 2019 Newton Foundation. All rights reserved.
//

import UIKit
import NewPaySDK_iOS

class ViewController: UIViewController {
    
    static let notificationID = "CaptureURLNotification"
    
    var hepPayInfoModel: HEPPayInfoModel? {
        didSet {
            updateStatus()
        }
    }
    
    var hepProofsModel: HEPProofsModel? {
        didSet {
            updateStatus()
        }
    }
    
    
    var newID: String? {
        didSet {
            updateStatus()
        }
    }
    
    let apiNetwork = APINetwork()
    
    lazy var sdk: NewtonSDK = {
        return NewtonSDK(
            dappId: "a4003fccf6f742c280dc0a2a862e80c1",
            bundleSource: "org.newtonproject.HEPDemo",
            environment: 3, /// Diffenrent environment for NewPay. 1 for release, 2 for testnet, 3 for dev
            schemaProtocol: "hep-demo" /// Used for jump back from NewPay
        )
    }()
    
    
    lazy var loginView: LoginView = {
        var view = LoginView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.btnAction = {
            self.loginClicked()
        }
        return view
    }()
    
    lazy var submitProofView: SubmitProofView = {
        var view = SubmitProofView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.btnAction = {
            self.submitProofClicked()
        }
        view.getInfoAction = {
            self.proofInfoClicked()
        }
        return view
    }()
    
    lazy var payView: PayView = {
        var view = PayView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.btnAction = {
            self.payClicked()
        }
        view.getInfoAction = {
            self.orderInfoClicked()
        }
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        
        let notificationName = Notification.Name(rawValue: ViewController.notificationID)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(captureURL(notification:)),
                                               name: notificationName, object: nil)
    }
    
    @objc func captureURL(notification: Notification) {
        if let userInfo = notification.userInfo as? [String: String] {
            guard let ursStr: String = userInfo["url"] else {
                return
            }
            let urlScheme = QRURLParser.schemeFrom(string: ursStr)
            if urlScheme.module == "hep.auth.login" {
                newID = urlScheme.param["newid"]
                loginView.updateView(urlSchema: urlScheme)
                if let errorcode = urlScheme.param["errorCode"], errorcode == "1" {
                    self.showAlert(title: "Login Success", message: "")
                } else {
                    self.showAlert(title: "Login Failed", message: "")
                }
            } else if urlScheme.module == "hep.pay.order" {
                if let errorcode = urlScheme.param["errorCode"], errorcode == "1" {
                    self.showAlert(title: "Payment Success", message: "")
                } else {
                    self.showAlert(title: "Payment Failed", message: "")
                }
            } else if urlScheme.module == "hep.proof.submit" {
                if let errorcode = urlScheme.param["errorCode"], errorcode == "1" {
                    self.showAlert(title: "Proof Submit Success", message: "")
                } else {
                    self.showAlert(title: "Proof Submit Failed", message: "")
                }
            }
        }
    }
    
    func setup() {
        self.view.addSubview(loginView)
        self.view.addSubview(submitProofView)
        self.view.addSubview(payView)
        
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            loginView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 18),
            loginView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -18),
            loginView.heightAnchor.constraint(equalToConstant: 200),
            
            payView.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 18),
            payView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 18),
            payView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -18),
            payView.heightAnchor.constraint(equalToConstant: 200),
            
            submitProofView.topAnchor.constraint(equalTo: payView.bottomAnchor, constant: 18),
            submitProofView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 18),
            submitProofView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -18),
            submitProofView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
    }
    
    func loginClicked() {

        loginView.updateView(urlSchema: nil)
        self.hepPayInfoModel = nil
        self.hepProofsModel = nil
        apiNetwork.getAuthLogin(params: ["os": "ios"], completion: { model in
            self.sdk.authLogin(
                memo: model.memo,
                signature: model.signature,
                signType: model.signType,
                scope: 2,
                nonce: model.nonce,
                ts: "\(model.ts)",
                uuid: model.uuid,
                completion: { result in
                    
                },
                failure: { result in
                    
                }
            )
        }, failure: {
            
        })
    }
    
    func orderInfoClicked() {
        guard let newID = newID else {
            return
        }
        self.displayLoading()
        apiNetwork.getAuthPay(
            params: ["newid": newID, "os": "ios"],
            completion: { model in
                self.hideLoading()

                self.hepPayInfoModel = model
            }, failure: {
                self.hideLoading()
            }
        )
    }
    
    func payClicked() {
        guard let model = hepPayInfoModel else {
            return
        }
        self.sdk.pay(
            signature: model.signature,
            signType: model.signType,
            description: model.description,
            priceCurrency: model.priceCurrency,
            totalPrice: model.totalPrice,
            orderNumber: model.orderNumber,
            seller: model.seller,
            customer: model.customer,
            broker: model.broker,
            nonce: model.nonce,
            ts: "\(model.ts)",
            uuid: model.uuid,
            completion: { result in
                
        },
            failure: {result in
                
        })
        
    }
    
    func proofInfoClicked() {
        guard let newID = newID else {
            return
        }
        self.displayLoading()
        
        apiNetwork.getAuthProof(
            params: ["newid": newID, "os": "ios"],
            completion: { model in
                self.hideLoading()

                self.hepProofsModel = model
            }, failure: {
                self.hideLoading()
            }
        )
    }
    
    func submitProofClicked() {
        
        guard let model = hepProofsModel else {
            return
        }

        self.sdk.placeOrder(
            signature: model.signature,
            signType: model.signType,
            proofHash: model.proof_hash,
            nonce: model.nonce,
            ts: "\(model.ts)",
            uuid: model.uuid,
            completion: { result in
                
            },
            failure: { result in
                
            }
        )
    }
   
    func updateStatus() {
        if let id = newID {
            submitProofView.isLogged = true
            payView.isLogged = true
        } else {
            submitProofView.isLogged = false
            payView.isLogged = false
        }

        submitProofView.gotInfo = hepProofsModel != nil
        payView.gotInfo = hepPayInfoModel != nil
        
        submitProofView.updateInfoLabel(with: hepProofsModel)
        payView.updateInfoLabel(with: hepPayInfoModel)
    }

}

