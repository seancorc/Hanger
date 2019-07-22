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
    var hangerView: UIImageView!
    var loginButton: UIButton!
    var signUpButton: UIButton!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var divderImageView: UIImageView!
    var dividerContainerView: UIView!
    
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
        loginButton.layer.cornerRadius = loginButton.frame.width / 8
    }

    
    func setupSubviews() {
        
        hangerView = UIImageView(image: UIImage(named: "Hanger")?.withRenderingMode(.alwaysTemplate))
        hangerView.tintColor = .black
        hangerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(hangerView)
        
        emailTextField = UITextField()
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        emailTextField.returnKeyType = .done
        emailTextField.textColor = .black
        emailTextField.font = UIFont(name: "Helvetica", size: 18)
        emailTextField.placeholder = "Email"
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.textAlignment = .center
        self.addSubview(emailTextField)
        
        passwordTextField = UITextField()
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        passwordTextField.returnKeyType = .done
        passwordTextField.textColor = .black
        passwordTextField.font = UIFont(name: "Helvetica", size: 18)
        passwordTextField.placeholder = "Password"
        passwordTextField.textAlignment = .center
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(passwordTextField)
        
        loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = #colorLiteral(red: 0.4360119624, green: 0.6691286069, blue: 1, alpha: 1)
        loginButton.setTitle("Sign In", for: UIControl.State.normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 24 * Global.ScaleFactor, weight: .heavy)
        loginButton.setTitleColor(.white, for: UIControl.State.normal)
        loginButton.clipsToBounds = true
        self.addSubview(loginButton)
        
        signUpButton = UIButton()
        let topText = NSMutableAttributedString(string: "Don't have an account? \n")
        let bottomText = NSMutableAttributedString(string: "Sign up for free", attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)])
        topText.append(bottomText)
        signUpButton.setAttributedTitle(topText, for: .normal)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        signUpButton.titleLabel?.numberOfLines = 2
        signUpButton.titleLabel?.textAlignment = .center
        self.addSubview(signUpButton)
        
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        hangerView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.04)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(96 * Global.ScaleFactor)
        }
        
        
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(hangerView.snp.bottom).offset(80 * Global.ScaleFactor)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(64 * Global.ScaleFactor)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(80 * Global.ScaleFactor)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        
        signUpButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(40 * Global.ScaleFactor)
        }
        
    }
    
}
