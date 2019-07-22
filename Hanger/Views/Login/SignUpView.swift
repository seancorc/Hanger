//
//  SignUpView.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/7/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class SignUpView: UIView {
    var backButton: UIButton!
    var signupLabel: UILabel!
    var emailTextField: UITextField!
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    var signUpButton: UIButton!
    
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
        signUpButton.layer.cornerRadius = signUpButton.frame.width / 8
    }
    
    
    func setupSubviews() {
        backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(named: "downarrow"), for: .normal)
        self.addSubview(backButton)
        
        signupLabel = UILabel()
        signupLabel.textColor = .black
        signupLabel.translatesAutoresizingMaskIntoConstraints = false
        signupLabel.text = "Sign Up"
        signupLabel.font = UIFont.systemFont(ofSize: 36 * Global.ScaleFactor, weight: .bold)
        self.addSubview(signupLabel)
        
        emailTextField = UITextField()
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        emailTextField.returnKeyType = .done
        emailTextField.textColor = .black
        emailTextField.font = UIFont(name: "Helvetica", size: 18 * Global.ScaleFactor)
        emailTextField.placeholder = "Email"
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.textAlignment = .center
        self.addSubview(emailTextField)
        
        usernameTextField = UITextField()
        usernameTextField.autocapitalizationType = .none
        usernameTextField.autocorrectionType = .no
        usernameTextField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        usernameTextField.returnKeyType = .done
        usernameTextField.textColor = .black
        usernameTextField.font = UIFont(name: "Helvetica", size: 18 * Global.ScaleFactor)
        usernameTextField.placeholder = "Username"
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.textAlignment = .center
        self.addSubview(usernameTextField)
        
        passwordTextField = UITextField()
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        passwordTextField.returnKeyType = .done
        passwordTextField.textColor = .black
        passwordTextField.font = UIFont(name: "Helvetica", size: 18 * Global.ScaleFactor)
        passwordTextField.placeholder = "Password"
        passwordTextField.textAlignment = .center
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(passwordTextField)
        
        signUpButton = UIButton()
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.backgroundColor = #colorLiteral(red: 0.4360119624, green: 0.6691286069, blue: 1, alpha: 1)
        signUpButton.setTitle("Sign Up", for: UIControl.State.normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 24 * Global.ScaleFactor, weight: .heavy)
        signUpButton.setTitleColor(.white, for: UIControl.State.normal)
        signUpButton.clipsToBounds = true
        self.addSubview(signUpButton)
        
        
        setupConstraints()
    }
    
    
    func setupConstraints() {
        
        signupLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(128 * Global.ScaleFactor)
        }
        
        backButton.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading).offset(20 * Global.ScaleFactor)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20 * Global.ScaleFactor)
            make.width.height.equalTo(Global.BackButtonSize)
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(signupLabel.snp.bottom).offset(80 * Global.ScaleFactor)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(64 * Global.ScaleFactor)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTextField.snp.bottom).offset(64 * Global.ScaleFactor)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        
        signUpButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(80 * Global.ScaleFactor)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        
    }
    
    func updateConstraintsForKeyboard(amount: CGFloat) {
        signupLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(50 + amount * Global.ScaleFactor)
            make.width.height.equalTo(150 * Global.ScaleFactor)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(signupLabel.snp.bottom).offset(80 * Global.ScaleFactor)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(64 * Global.ScaleFactor)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.08)
            if amount != 0 {make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(amount)}
            else {make.top.equalTo(usernameTextField.snp.bottom).offset(64 * Global.ScaleFactor)}
        }
        
    
    
    
}

}
