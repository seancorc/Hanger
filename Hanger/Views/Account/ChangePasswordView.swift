//
//  ChangePasswordView.swift
//  Carbon38
//
//  Created by dev on 6/18/19.
//  Copyright © 2019 Carbon38. All rights reserved.
//

import UIKit

class ChangePasswordView: UIView {
    var backButton: UIButton!
    var currentPasswordTextField: UITextField!
    var newPasswordTextField: UITextField!
    var changePasswordButton: UIButton!
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        changePasswordButton.layer.cornerRadius = changePasswordButton.frame.width / 8
    }
    
    func setupSubviews() {
        backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(named: "downarrow"), for: .normal)
        self.addSubview(backButton)
        
        currentPasswordTextField = UITextField()
        currentPasswordTextField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        currentPasswordTextField.returnKeyType = .done
        currentPasswordTextField.textColor = .black
        currentPasswordTextField.font = UIFont(name: "Helvetica", size: 18 * Global.ScaleFactor)
        currentPasswordTextField.placeholder = "Current Password"
        currentPasswordTextField.isSecureTextEntry = true
        currentPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        currentPasswordTextField.textAlignment = .center
        self.addSubview(currentPasswordTextField)
        
        newPasswordTextField = UITextField()
        newPasswordTextField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        newPasswordTextField.returnKeyType = .done
        newPasswordTextField.textColor = .black
        newPasswordTextField.font = UIFont(name: "Helvetica", size: 18 * Global.ScaleFactor)
        newPasswordTextField.placeholder = "New Password"
        newPasswordTextField.textAlignment = .center
        newPasswordTextField.isSecureTextEntry = true
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(newPasswordTextField)
        
        changePasswordButton = UIButton()
        changePasswordButton.setTitle("Change Password", for: .normal)
        changePasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 24 * Global.ScaleFactor, weight: .heavy)
        changePasswordButton.setTitleColor(UIColor.white, for: .normal)
        changePasswordButton.backgroundColor = #colorLiteral(red: 0.4360119624, green: 0.6691286069, blue: 1, alpha: 1)
        self.addSubview(changePasswordButton)
        
        setupConstraints()
    }
    
    
    func setupConstraints() {
        backButton.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading).offset(20 * Global.ScaleFactor)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20 * Global.ScaleFactor)
            make.width.height.equalTo(Global.BackButtonSize)
        }
        
        currentPasswordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(backButton.snp.bottom).offset(128 * Global.ScaleFactor)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        
        newPasswordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(currentPasswordTextField.snp.bottom).offset(64 * Global.ScaleFactor)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        
        changePasswordButton.snp.makeConstraints { (make) in
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(80 * Global.ScaleFactor)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        
    }
    
    

}

