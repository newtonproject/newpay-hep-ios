//
//  InputTextView.swift
//  HEPDemo
//
//  Created by Heng Yiwei on 2020/3/16.
//  Copyright © 2020 Yiwei Heng. All rights reserved.
//

import Foundation

class InputTextView: UIView {
    
    var content: String {
        get {
            return inputTextField.text ?? ""
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }()
    
    lazy var inputTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter here"
        tf.delegate = self
        return tf
    }()
    
    convenience init(frame: CGRect, title: String) {
        self.init(frame: frame)
        setup(title: title)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(title: String) {
        
        self.addSubview(titleLabel)
        self.addSubview(inputTextField)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 18),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            inputTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            inputTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 18),
            inputTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18),
            inputTextField.heightAnchor.constraint(equalToConstant: 20),
            
            inputTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        
        ])
        
        titleLabel.text = title
    }
}

extension InputTextView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
}
