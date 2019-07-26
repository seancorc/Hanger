//
//  SignUpView.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/7/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class SignUpView: UIView {
    
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "downarrow"), for: .normal)
        return button
    }()
    
    lazy var signupLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sign Up"
        label.font = UIFont.systemFont(ofSize: 36 * Global.ScaleFactor, weight: .bold)
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
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
    
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        textField.returnKeyType = .done
        textField.textColor = .black
        textField.font = UIFont(name: "Helvetica", size: 18 * Global.ScaleFactor)
        textField.placeholder = "Username"
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
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.4360119624, green: 0.6691286069, blue: 1, alpha: 1)
        button.setTitle("Sign Up", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24 * Global.ScaleFactor, weight: .heavy)
        button.setTitleColor(.white, for: UIControl.State.normal)
        button.clipsToBounds = true
        return button
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
        signUpButton.layer.cornerRadius = signUpButton.frame.width / 8
    }
    
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        self.addSubview(dismissButton)
        
        self.addSubview(signupLabel)

        self.addSubview(emailTextField)
        
        self.addSubview(usernameTextField)
        
        self.addSubview(passwordTextField)
        
        self.addSubview(signUpButton)
        
        setupConstraints()
    }
    
    
    func setupConstraints() {
        
        signupLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(128 * Global.ScaleFactor)
        }
        
        dismissButton.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading).offset(20 * Global.ScaleFactor)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20 * Global.ScaleFactor)
            make.width.height.equalTo(35 * Global.ScaleFactor)
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
