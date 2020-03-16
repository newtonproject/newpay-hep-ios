//
//  SignMsgView.swift
//  HEPDemo
//
//  Created by Heng Yiwei on 2020/3/16.
//  Copyright © 2020 Yiwei Heng. All rights reserved.
//

import Foundation

class SignMsgView: UIView {
    
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
            return message != ""
        }
    }
    
    var message: String {
        get {
            return inputMsgView.content
        }
    }
    
    lazy var inputMsgView: InputTextView = {
        let v = InputTextView(frame: .zero, title: "Message")
        v.translatesAutoresizingMaskIntoConstraints = false
        
        
        return v
    }()
    
    lazy var sendBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Sign Message", for: .normal)
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
        
        self.addSubview(inputMsgView)
        self.addSubview(sendBtn)
        self.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            
            inputMsgView.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            inputMsgView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            inputMsgView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18),
            inputMsgView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
        
            sendBtn.topAnchor.constraint(equalTo: inputMsgView.bottomAnchor, constant: 18),
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
