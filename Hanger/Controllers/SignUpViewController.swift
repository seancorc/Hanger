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
//        NetworkManager.signUp(email: signUpView.emailTextField.text!, username: "Ahhh", password: signUpView.passwordTextField.text!) { (User, success)  in
//            if success {
//                let appDelegate = UIApplication.shared.delegate as? AppDelegate
//                let tabBarController = TabBarController()
//                let snapshot: UIView? = appDelegate?.window?.snapshotView(afterScreenUpdates: true)
//                let loginViewController = UIApplication.shared.keyWindow?.rootViewController
//                UIApplication.shared.keyWindow?.rootViewController = tabBarController
//                if let snapshot = snapshot {
//                    tabBarController.view.addSubview(snapshot)
//                    UIView.animate(withDuration: 0.5, animations: {
//                        snapshot.layer.opacity = 0
//                        snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
//                    }, completion: { (completed) in
//                        snapshot.removeFromSuperview()
//                        loginViewController?.removeFromParent()
//                    })
//                }
//            } else {
//
//            }
//        }
        
        NetworkManager.shared.execute(request: UserRequests.signUp(email: signUpView.emailTextField.text!, username: "Ahhh", password: signUpView.passwordTextField.text!)) { (json) in
            print(json)
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


