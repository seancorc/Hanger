//
//  LoginViewController.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/1/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    var loginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.uiDelegate = self
        
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
        NetworkManager.login(email: loginView.emailTextField.text!, password: loginView.passwordTextField.text!) { (user, success) in
            print(user)
            print(success)
            if success {
                self.loginView.emailTextField.resignFirstResponder()
                self.loginView.passwordTextField.resignFirstResponder()
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                let tabBarController = TabBarController()
                let snapshot: UIView? = appDelegate?.window?.snapshotView(afterScreenUpdates: true)
                let loginViewController = UIApplication.shared.keyWindow?.rootViewController
                UIApplication.shared.keyWindow?.rootViewController = tabBarController
                if let snapshot = snapshot {
                    tabBarController.view.addSubview(snapshot)
                    UIView.animate(withDuration: 0.5, animations: {
                        snapshot.layer.opacity = 0
                        snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
                    }, completion: { (completed) in
                        snapshot.removeFromSuperview()
                        loginViewController?.removeFromParent()
                    })
                }
            } else {
                
            }
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
