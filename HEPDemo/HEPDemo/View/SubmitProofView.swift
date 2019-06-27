//
//  submitProofView.swift
//  HEPDemo
//
//  Created by Newton Foundation on 2019/6/18.
//  Copyright © 2019 Newton Foundation. All rights reserved.
//

import Foundation
import UIKit

class SubmitProofView: UIView {
    
    var getInfoAction: (() -> Void)?
    var btnAction: (()-> Void)?
    
    var isLogged: Bool = false {
        didSet {
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.infoBtn.isEnabled = self.isLogged
                self.infoBtn.layer.borderColor = self.isLogged ? UIColor.black.cgColor : UIColor.gray.cgColor
            }

           
        }
    }
    
    var gotInfo: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.proofBtn.isEnabled = self.isLogged && self.gotInfo
                self.infoLabel.isHidden = !(self.isLogged && self.gotInfo)
                self.proofBtn.layer.borderColor = self.isLogged && self.gotInfo ? UIColor.black.cgColor : UIColor.gray.cgColor
            }
        }
    }
    
    lazy var infoBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(infoBtnClicked), for: .touchUpInside)
        btn.setTitle("Proof Info", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitleColor(.gray, for: .disabled)
        btn.layer.borderColor = UIColor.gray.cgColor
        btn.layer.borderWidth = 1
        btn.backgroundColor = .white
        btn.isEnabled = false
        return btn
    }()
    
    lazy var proofBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        btn.setTitle("Proof", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitleColor(.gray, for: .disabled)
        btn.layer.borderColor = UIColor.gray.cgColor
        btn.layer.borderWidth = 1
        btn.backgroundColor = .white
        btn.isEnabled = false
        return btn
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 0
        label.isHidden = true

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        self.layer.borderWidth = 1
        
        self.addSubview(infoBtn)
        self.addSubview(proofBtn)
        self.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            
            infoBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            infoBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 18),
            infoBtn.widthAnchor.constraint(equalToConstant: 100),
            infoBtn.heightAnchor.constraint(equalToConstant: 30),
            
            proofBtn.topAnchor.constraint(equalTo: infoBtn.bottomAnchor, constant: 18),
            proofBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 18),
            proofBtn.widthAnchor.constraint(equalToConstant: 60),
            proofBtn.heightAnchor.constraint(equalToConstant: 30),
            
            infoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            infoLabel.leftAnchor.constraint(equalTo: infoBtn.rightAnchor, constant: 18),
            infoLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18),
            infoLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -18)
        ])
    }
    
    @objc func btnClicked () {
        btnAction?()
    }
    
    @objc func infoBtnClicked () {
        getInfoAction?()
    }
    
    func updateInfoLabel(with model: HEPProofsModel?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            if let info = model {
                self.infoLabel.text = "Proof Hash: \n" + info.proof_hash
                self.proofBtn.isEnabled = true
                self.proofBtn.layer.borderColor = UIColor.black.cgColor
                
            } else {
                self.infoLabel.text = ""
                self.proofBtn.isEnabled = false
                self.proofBtn.layer.borderColor = UIColor.gray.cgColor
            }
        }
        
    }
}
