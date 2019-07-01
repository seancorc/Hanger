//
//  LoginView.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/1/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit
import SnapKit
import GoogleSignIn

class LoginView: UIView {
    var imagineClothesLabel: UILabel!
    var loginButton: NiceSpacingButton!
    var googleSignInButton: GIDSignInButton!
    var signUpButton: UIButton!
    var usernameTextField: UITextField!
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
    
    func setupSubviews() {
        
        imagineClothesLabel = UILabel()
        imagineClothesLabel.translatesAutoresizingMaskIntoConstraints = false
        imagineClothesLabel.font = UIFont.systemFont(ofSize: 32)
        imagineClothesLabel.text = "ImagineClothes"
        imagineClothesLabel.textAlignment = .center
        self.addSubview(imagineClothesLabel)
        
        googleSignInButton = GIDSignInButton()
        googleSignInButton.translatesAutoresizingMaskIntoConstraints = false
        googleSignInButton.style = .wide
        googleSignInButton.colorScheme = .light
        self.addSubview(googleSignInButton)
        
        usernameTextField = UITextField()
        usernameTextField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        usernameTextField.returnKeyType = .done
        usernameTextField.textColor = .black
        usernameTextField.font = UIFont(name: "Helvetica", size: 18)
        usernameTextField.placeholder = "Email"
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.textAlignment = .center
        self.addSubview(usernameTextField)
        
        passwordTextField = UITextField()
        passwordTextField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        passwordTextField.returnKeyType = .done
        passwordTextField.textColor = .black
        passwordTextField.font = UIFont(name: "Helvetica", size: 18)
        passwordTextField.placeholder = "Password"
        passwordTextField.textAlignment = .center
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(passwordTextField)
        
        loginButton = NiceSpacingButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        loginButton.backgroundColor = #colorLiteral(red: 0.9911627173, green: 0.6678413749, blue: 0.3004458249, alpha: 1)
        self.addSubview(loginButton)
        
        dividerContainerView = UIView()
        dividerContainerView.backgroundColor = .white
        self.addSubview(dividerContainerView)
        
        divderImageView = UIImageView(image: UIImage(named: "logindividerimage"))
        divderImageView.translatesAutoresizingMaskIntoConstraints = false
        dividerContainerView.addSubview(divderImageView)
        
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
        imagineClothesLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(80)
        }
        
        googleSignInButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.top.equalTo(imagineClothesLabel.snp.top).offset(96)
        }
        
        dividerContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(googleSignInButton.snp.bottom)
            make.bottom.equalTo(usernameTextField.snp.top)
            make.centerX.equalToSuperview()
        }
        
        divderImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(googleSignInButton.snp.bottom).offset(96)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.05)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTextField.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.05)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(60)
        }
        
        signUpButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(40)
        }
        
    }
    
}
