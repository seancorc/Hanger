//
//  LoginViewController.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/1/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    var loginView: LoginView!
    
    //Hanger todos change categories section to filter (possibly), start implementing dependency injection, fix googlesignin
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loginView = LoginView()
        loginView.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        loginView.emailTextField.delegate = self
        loginView.passwordTextField.delegate = self
        loginView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginView)
        loginView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
    }
    
    @objc func loginButtonPressed() {
//        NetworkManager.login(email: loginView.emailTextField.text!, password: loginView.passwordTextField.text!) { (user, success) in
//            print(user)
//            print(success)
//            if success {
//                self.loginView.emailTextField.resignFirstResponder()
//                self.loginView.passwordTextField.resignFirstResponder()
//                HelpfulFunctions.signInAnimation()
//            } else {
//
//            }
//        }
        
        NetworkManager.shared.execute(request: UserRequests.login(email: loginView.emailTextField.text!
            , password: loginView.passwordTextField.text!)) { (json) in
                print(json)
        }
        
 
    }
    
    @objc func signUpButtonPressed() {
        present(SignUpViewController(), animated: true, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
