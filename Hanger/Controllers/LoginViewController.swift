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
    var userManager: UserManager!
    var networkManager: NetworkManager!
    
    init(userManager: UserManager = .currentUser(), networkManager: NetworkManager = .shared()) {
        super.init(nibName: nil, bundle: nil)
        self.userManager = userManager
        self.networkManager = networkManager
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        var email = ""; var password = ""
        do {
            email = try loginView.emailTextField.text!.validateText(validationType: .email)
            password = try loginView.passwordTextField.text!.validateText(validationType: .password)
        } catch {
            present(HelpfulFunctions.createAlert(for: (error as! MessageError).message), animated: true, completion: nil)
            return
        }
        let loginTask = LoginTask(email: email, password: password)
        loginTask.execute(in: self.networkManager) { (user, responseError) in
            if let err = responseError {
                self.present(HelpfulFunctions.createAlert(for: err.message), animated: true, completion: nil)
                return
            }
            self.userManager.user = user
            HelpfulFunctions.signInAnimation()
            self.loginView.emailTextField.resignFirstResponder()
            self.loginView.passwordTextField.resignFirstResponder()
        }
    }
    
    @objc func signUpButtonPressed() {
        present(SignUpViewController(userManager: UserManager.currentUser(), networkManager: NetworkManager.shared()), animated: true, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
