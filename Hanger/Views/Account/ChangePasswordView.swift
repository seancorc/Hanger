//
//  ChangePasswordView.swift
//  Carbon38
//
//  Created by dev on 6/18/19.
//  Copyright © 2019 Carbon38. All rights reserved.
//

import UIKit

class ChangePasswordView: UIView {
    
    lazy var currentPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.clipsToBounds = true
        textField.backgroundColor = .white
        textField.returnKeyType = .done
        textField.textColor = .black
        textField.font = UIFont(name: "Helvetica", size: 18 * Global.ScaleFactor)
        textField.placeholder = "Current Password"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 2
        return textField
    }()
    
    lazy var newPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.clipsToBounds = true
        textField.backgroundColor = .white
        textField.returnKeyType = .done
        textField.textColor = .black
        textField.font = UIFont(name: "Helvetica", size: 18 * Global.ScaleFactor)
        textField.placeholder = "New Password"
        textField.textAlignment = .center
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 2
        return textField
    }()
    
    lazy var changePasswordButton: NiceSpacingButton = {
        let button = NiceSpacingButton()
        button.setupButton(title: "Change Password", backgroundColor: #colorLiteral(red: 0.4360119624, green: 0.6691286069, blue: 1, alpha: 1))
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        currentPasswordTextField.layer.cornerRadius = currentPasswordTextField.frame.width / 10
        newPasswordTextField.layer.cornerRadius = newPasswordTextField.frame.width / 10
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        self.addSubview(currentPasswordTextField)

        self.addSubview(newPasswordTextField)
        
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



