//
//  LoginView.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/1/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    lazy var hangerView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Hanger")?.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 28/255, green: 183/255, blue: 1, alpha: 1)
        button.setTitle("Sign In", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24 * Global.ScaleFactor, weight: .heavy)
        button.setTitleColor(.white, for: UIControl.State.normal)
        button.clipsToBounds = true
        return button
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        let topText = NSMutableAttributedString(string: "Don't have an account? \n")
        let bottomText = NSMutableAttributedString(string: "Sign up for free", attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)])
        topText.append(bottomText)
        button.setAttributedTitle(topText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        textField.returnKeyType = .done
        textField.textColor = .black
        textField.font = UIFont(name: "Helvetica", size: 18)
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        textField.returnKeyType = .done
        textField.textColor = .black
        textField.font = UIFont(name: "Helvetica", size: 18)
        textField.placeholder = "Password"
        textField.textAlignment = .center
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        loginButton.layer.cornerRadius = loginButton.frame.width / 8
    }

    
    override func didMoveToSuperview() {
        super.didMoveToSuperview() //Call super just to be safe
        
        self.addSubview(hangerView)
        
        self.addSubview(emailTextField)
        
        self.addSubview(passwordTextField)
        
        self.addSubview(loginButton)
        
        self.addSubview(signUpButton)
        
        
        setupConstraints()
    }
    
    func setupConstraints() {
        let hangerViewOffset = 96 * Global.ScaleFactor
        let emailTextFieldLoginButtonOffset = 80 * Global.ScaleFactor
        let passwordTextFieldOffset = 64 * Global.ScaleFactor
        let signUpButtonOffset = 40 * Global.ScaleFactor
        
        hangerView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.04)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(hangerViewOffset)
        }
        
        
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(hangerView.snp.bottom).offset(emailTextFieldLoginButtonOffset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(passwordTextFieldOffset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(emailTextFieldLoginButtonOffset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        
        signUpButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(signUpButtonOffset)
        }
        
    }
    
}
