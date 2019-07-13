//
//  SignUpViewController.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/7/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit
import MapKit

class SignUpViewController: UIViewController {
    var signUpView: SignUpView!
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
        
        signUpView = SignUpView()
        signUpView.translatesAutoresizingMaskIntoConstraints = false
        signUpView.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        signUpView.signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        signUpView.emailTextField.delegate = self
        signUpView.passwordTextField.delegate = self
        view.addSubview(signUpView)
        signUpView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    @objc func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func signUpButtonPressed() {
        do {
            let email = try signUpView.emailTextField.validateText(validationType: .email)
            let username = try signUpView.usernameTextField.validateText(validationType: .username)
            let password = try signUpView.passwordTextField.validateText(validationType: .password)
            let signUpTask = SignUpTask(email: email, username: username, password: password)
            signUpTask.execute(in: self.networkManager) { (user) in
                self.userManager.user = user
                HelpfulFunctions.signInAnimation()
                self.signUpView.emailTextField.resignFirstResponder()
                self.signUpView.passwordTextField.resignFirstResponder()
            }
        } catch {
            present(HelpfulFunctions.createAlert(for: (error as! ValidationError).message), animated: true, completion: nil)
        }
        
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


