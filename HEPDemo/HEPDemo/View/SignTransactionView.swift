//
//  SignTransView.swift
//  HEPDemo
//
//  Created by Heng Yiwei on 2020/3/16.
//  Copyright © 2020 Yiwei Heng. All rights reserved.
//

import Foundation

class SignTransactionView: UIView {
    
    var btnAction: (() -> Void)?
    var result: String = "" {
        didSet {
            DispatchQueue.main.async {
                self.resultLabel.text = self.result
            }
        }
    }
    
    var shouldSend: Bool {
        get {
            return amount != "" && from != "" && to != "" && gasLimit != "" && gasPrice != "" && transactionCount != "" && data != "" 
        }
    }
    
    var amount: String {
        get {
            return inputAmountView.content
        }
    }
    
    var from: String {
        get {
            return inputFromView.content
        }
    }
    
    var to: String {
        get {
            return inputToView.content
        }
    }
    
    var gasLimit: String {
        get {
            return inputGasLimitView.content
        }
    }
    
    var gasPrice: String {
        get {
            return inputGasPriceView.content
        }
    }
    
    var transactionCount: String {
        get {
            return inputTransactionCountView.content
        }
    }
    
    var data: String {
        get {
            return inputDataView.content
        }
    }
    
    lazy var inputAmountView: InputTextView = {
        let v = InputTextView(frame: .zero, title: "Amount")
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var inputFromView: InputTextView = {
        let v = InputTextView(frame: .zero, title: "From Address")
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var inputToView: InputTextView = {
        let v = InputTextView(frame: .zero, title: "To Address")
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var inputGasPriceView: InputTextView = {
        let v = InputTextView(frame: .zero, title: "Gas Price")
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var inputGasLimitView: InputTextView = {
        let v = InputTextView(frame: .zero, title: "Gas Limit")
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var inputTransactionCountView: InputTextView = {
        let v = InputTextView(frame: .zero, title: "Transaction Count")
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var inputDataView: InputTextView = {
        let v = InputTextView(frame: .zero, title: "Data")
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var sendBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Sign Transaction", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
        btn.addTarget(self, action: #selector(sendBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    lazy var resultLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        self.layer.borderWidth = 1
        
        self.addSubview(inputAmountView)
        self.addSubview(inputToView)
        self.addSubview(inputFromView)
        self.addSubview(inputGasPriceView)
        self.addSubview(inputGasLimitView)
        self.addSubview(inputTransactionCountView)
        self.addSubview(inputDataView)
        
        self.addSubview(sendBtn)
        self.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            
            inputAmountView.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            inputAmountView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            inputAmountView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18),
            inputAmountView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            inputToView.topAnchor.constraint(equalTo: inputAmountView.bottomAnchor, constant: 18),
            inputToView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            inputToView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18),
            inputToView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            inputFromView.topAnchor.constraint(equalTo: inputToView.bottomAnchor, constant: 18),
            inputFromView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            inputFromView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18),
            inputFromView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            inputGasPriceView.topAnchor.constraint(equalTo: inputFromView.bottomAnchor, constant: 18),
            inputGasPriceView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            inputGasPriceView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18),
            inputGasPriceView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            inputGasLimitView.topAnchor.constraint(equalTo: inputGasPriceView.bottomAnchor, constant: 18),
            inputGasLimitView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            inputGasLimitView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18),
            inputGasLimitView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            inputTransactionCountView.topAnchor.constraint(equalTo: inputGasLimitView.bottomAnchor, constant: 18),
            inputTransactionCountView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            inputTransactionCountView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18),
            inputTransactionCountView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            inputDataView.topAnchor.constraint(equalTo: inputTransactionCountView.bottomAnchor, constant: 18),
            inputDataView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            inputDataView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18),
            inputDataView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
        
            sendBtn.topAnchor.constraint(equalTo: inputDataView.bottomAnchor, constant: 18),
            sendBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18),
            sendBtn.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 18),
            sendBtn.heightAnchor.constraint(equalToConstant: 30),

            resultLabel.topAnchor.constraint(equalTo: sendBtn.bottomAnchor, constant: 16),
            resultLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 18),
            resultLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18),
            resultLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            resultLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -18)
        ])
        
    }
    
    @objc func sendBtnClicked() {
        btnAction?()
    }
    
}
