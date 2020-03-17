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
    
    var address: String? {
        didSet {
            transactionView.inputFromView.inputTextField.text = address
        }
    }
    
    var dappID: String? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                self.loginView.loginBtn.isEnabled = self.dappID != nil
            }
        }
    }
    
    let apiNetwork = APINetwork()
    
    lazy var sdk: NewtonSDK = {
        return NewtonSDK(
            dappId: dappID ?? "",
            bundleSource: Config().bundleSource,
            environment: Config().environment,
            schemaProtocol: Config().schemeProtocol /// Used for jump back from NewPay
        )
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        return view
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
    
    lazy var msgView: SignMsgView = {
        let v = SignMsgView(frame: .zero)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.btnAction = {
            self.signMessageBtnClicked()
        }
        return v
    }()
    
    lazy var transactionView: SignTransactionView = {
        let v = SignTransactionView(frame: .zero)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.btnAction = {
            self.signTransactionBtnClicked()
        }
        return v
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        getDappID()
        view.tapToHideKeyboard()
            
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
                address = urlScheme.param["address"]
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
            } else if urlScheme.module == "hep.sign.message" {
                if let errorcode = urlScheme.param["errorCode"], errorcode == "1" {
                    self.showAlert(title: "Sign Message Success", message: "")
                    self.msgView.result = urlScheme.param["signature"] ?? ""
                } else {
                    self.showAlert(title: "Proof Submit Failed", message: "")
                }
            }  else if urlScheme.module == "hep.sign.transaction" {
                if let errorcode = urlScheme.param["errorCode"], errorcode == "1" {
                    self.showAlert(title: "Sign Transaction Success", message: "")
                    self.transactionView.result = urlScheme.param["signed_transaction"] ?? ""
                } else {
                    self.showAlert(title: "Sign Transaction Failed", message: "")
                }
            }
        }
    }
        
    func setup() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(loginView)
        scrollView.addSubview(submitProofView)
        scrollView.addSubview(payView)
        scrollView.addSubview(msgView)
        scrollView.addSubview(transactionView)
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 18),
            scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -18),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loginView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 60),
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
            submitProofView.heightAnchor.constraint(equalToConstant: 150),
            
            msgView.topAnchor.constraint(equalTo: submitProofView.bottomAnchor, constant: 18),
            msgView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 18),
            msgView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -18),
            msgView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            transactionView.topAnchor.constraint(equalTo: msgView.bottomAnchor, constant: 18),
            transactionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 18),
            transactionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -18),
            transactionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            transactionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -300),
        ])
            
    }
        
    func getDappID() {
        self.displayLoading()
        apiNetwork.getAuthLogin(params: ["os": "ios"], completion: { model in
            self.hideLoading()
            self.dappID = model.dappID
                
        }, failure: {
            self.hideLoading()
            self.showAlert(title: "HEPDemo", message: "Failed to get Dapp ID")
        })
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
                ts: model.ts,
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
            ts: model.ts,
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
            ts: model.ts,
            uuid: model.uuid,
            completion: { result in
                    
            },
            failure: { result in
                    
            }
        )
    }
       
    @objc func signMessageBtnClicked() {
        if msgView.shouldSend {
        
            self.displayLoading()
            apiNetwork.getSignMessage(
                params: [
                    "os": "ios",
                    "message": msgView.message
                ],
                completion: { model in
                    self.hideLoading()
                    self.sdk.signMessage(
                        signature: model.signature,
                        message: model.message,
                        nonce: model.nonce,
                        ts: model.ts,
                        uuid: model.uuid,
                        completion: { result in
                            
                        },
                        failure: { result in
                            
                        }
                    )
                    
                }, failure: {
                    self.hideLoading()
                }
            )
        } else {
            self.showAlert(title: "HEP", message: "Input Missing")
        }

    }
        
    @objc func signTransactionBtnClicked() {
        if let walletAddress = address {
            
            if transactionView.shouldSend {
                self.displayLoading()
                apiNetwork.getSignTransaction(
                    params: [
                        "os": "ios",
                        "amount": transactionView.amount,
                        "from": walletAddress,
                        "to": transactionView.to,
                        "transaction_count": transactionView.transactionCount,
                        "gas_price": transactionView.gasPrice,
                        "gas_limit": transactionView.gasLimit,
                        "data": transactionView.data
                    ],
                    completion: { model in
                        self.hideLoading()
                                
                        self.sdk.signTransaction(
                            signature: model.signature,
                            amount: model.amount,
                            from: model.from,
                            to: model.to,
                            nonce: model.nonce,
                            gasPrice: model.gasPrice,
                            gasLimit: model.gasLimit,
                            data: model.data,
                            transactionCount: model.transactionCount,
                            ts: model.ts,
                            uuid: model.uuid,
                            completion: { result in
                                
                            },
                            failure: { result in
                            }
                        )
                    }, failure: {
                        self.hideLoading()
                    }
                )
            } else {
                self.showAlert(title: "HEP", message: "Input Missing")
            }
        } else {
            self.showAlert(title: "HEP", message: "Login first")
        }
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

