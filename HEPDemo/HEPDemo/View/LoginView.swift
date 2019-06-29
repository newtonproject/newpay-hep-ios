//
//  loginView.swift
//  HEPDemo
//
//  Created by Newton Foundation on 2019/6/18.
//  Copyright © 2019 Newton Foundation. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class LoginView: UIView {
    
    var btnAction: (()-> Void)?
    
    lazy var loginBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        btn.setTitle("Sign in", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
        btn.backgroundColor = .white
        btn.isEnabled = false
        return btn
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .right
        return label
    }()
    
    lazy var newIDLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 9)
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 9)
        return label
    }()
    
    lazy var inviteCodeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 9)
        return label
    }()
    
    lazy var phoneLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 9)
        return label
    }()
    
    lazy var iconImgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.isHidden = true
        imgView.layer.cornerRadius = 40
        imgView.clipsToBounds = true
        return imgView
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
        
        self.addSubview(loginBtn)
        self.addSubview(iconImgView)
        self.addSubview(nameLabel)
        self.addSubview(inviteCodeLabel)
        self.addSubview(phoneLabel)
        
        self.addSubview(addressLabel)
        self.addSubview(newIDLabel)
        
        NSLayoutConstraint.activate([
            loginBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            loginBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 18),
            loginBtn.widthAnchor.constraint(equalToConstant: 60),
            loginBtn.heightAnchor.constraint(equalToConstant: 30),
            
            iconImgView.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            iconImgView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18),
            iconImgView.widthAnchor.constraint(equalToConstant: 80),
            iconImgView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.topAnchor.constraint(equalTo: loginBtn.topAnchor, constant: 18),
            nameLabel.rightAnchor.constraint(equalTo: iconImgView.leftAnchor, constant: -36),
            nameLabel.widthAnchor.constraint(equalToConstant: 200),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            inviteCodeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 18),
            inviteCodeLabel.rightAnchor.constraint(equalTo: iconImgView.leftAnchor, constant: -36),
            inviteCodeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 18),
            inviteCodeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            phoneLabel.topAnchor.constraint(equalTo: inviteCodeLabel.bottomAnchor, constant: 0),
            phoneLabel.rightAnchor.constraint(equalTo: iconImgView.leftAnchor, constant: -36),
            phoneLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 18),
            phoneLabel.heightAnchor.constraint(equalToConstant: 20),
            
            addressLabel.bottomAnchor.constraint(equalTo: newIDLabel.topAnchor, constant: 0),
            addressLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18),
            addressLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 18),
            addressLabel.heightAnchor.constraint(equalToConstant: 20),
            
            newIDLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -18),
            newIDLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18),
            newIDLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 18),
            newIDLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func updateView(urlSchema: URLScheme?) {
        if let urlS = urlSchema {
            nameLabel.isHidden = false
            newIDLabel.isHidden = false
            iconImgView.isHidden = false
            phoneLabel.isHidden = false
            addressLabel.isHidden = false
            inviteCodeLabel.isHidden = false
            
            nameLabel.text = urlSchema?.param["name"] ?? ""
            newIDLabel.text = urlSchema?.param["newid"] ?? ""
            iconImgView.sd_setImage(with: URL(string: urlSchema?.param["avatar"] ?? ""), placeholderImage: UIImage(named: "placeHolder"))
            
            phoneLabel.text = "Phone: \(urlSchema?.param["country_code"] ?? "") \(urlSchema?.param["cellphone"] ?? "")"
            addressLabel.text = "Wallet Address: \(urlSchema?.param["address"] ?? "")"
            inviteCodeLabel.text = "Invite Code: \(urlSchema?.param["invite_code"] ?? "")"
            
            print("Sign Type: \(urlSchema?.param["sign_type"] ?? "")")
            print("Signature: \(urlSchema?.param["signature"] ?? "")")
            
        } else {
            nameLabel.isHidden = true
            newIDLabel.isHidden = true
            iconImgView.isHidden = true
            phoneLabel.isHidden = true
            addressLabel.isHidden = true
            inviteCodeLabel.isHidden = true
            
            nameLabel.text = ""
            newIDLabel.text = ""
            iconImgView.image = UIImage(named: "placeHolder")
            
            phoneLabel.text = ""
            addressLabel.text = ""
            inviteCodeLabel.text = ""
        }
    }
    
    @objc func btnClicked () {
        btnAction?()
    }
}
