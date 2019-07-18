//
//  ChangePasswordView.swift
//  Carbon38
//
//  Created by dev on 6/18/19.
//  Copyright © 2019 Carbon38. All rights reserved.
//

import UIKit

class ChangePasswordView: UIView {
    var currentPasswordTextField: UITextField!
    var newPasswordTextField: UITextField!
    var changePasswordButton: NiceSpacingButton!
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(white: 0.95, alpha: 1)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        currentPasswordTextField.layer.cornerRadius = currentPasswordTextField.frame.width / 10
        newPasswordTextField.layer.cornerRadius = newPasswordTextField.frame.width / 10
    }
    
    func setupSubviews() {
        
        currentPasswordTextField = UITextField()
        currentPasswordTextField.clipsToBounds = true
        currentPasswordTextField.backgroundColor = .white
        currentPasswordTextField.returnKeyType = .done
        currentPasswordTextField.textColor = .black
        currentPasswordTextField.font = UIFont(name: "Helvetica", size: 18 * Global.ScaleFactor)
        currentPasswordTextField.placeholder = "Current Password"
        currentPasswordTextField.isSecureTextEntry = true
        currentPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        currentPasswordTextField.textAlignment = .center
        currentPasswordTextField.layer.borderColor = UIColor.gray.cgColor
        currentPasswordTextField.layer.borderWidth = 2
        self.addSubview(currentPasswordTextField)
        
        newPasswordTextField = UITextField()
        newPasswordTextField.clipsToBounds = true
        newPasswordTextField.backgroundColor = .white
        newPasswordTextField.returnKeyType = .done
        newPasswordTextField.textColor = .black
        newPasswordTextField.font = UIFont(name: "Helvetica", size: 18 * Global.ScaleFactor)
        newPasswordTextField.placeholder = "New Password"
        newPasswordTextField.textAlignment = .center
        newPasswordTextField.isSecureTextEntry = true
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        newPasswordTextField.layer.borderColor = UIColor.gray.cgColor
        newPasswordTextField.layer.borderWidth = 2
        self.addSubview(newPasswordTextField)
        
        changePasswordButton = NiceSpacingButton()
        changePasswordButton.setupButton(title: "Change Password", backgroundColor: #colorLiteral(red: 0.4360119624, green: 0.6691286069, blue: 1, alpha: 1))
        self.addSubview(changePasswordButton)
        
        setupConstraints()
    }
    
    
    func setupConstraints() {
        
        currentPasswordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(128 * Global.ScaleFactor)
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
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(96 * Global.ScaleFactor)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        
    }
    
    
    
}



