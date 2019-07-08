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
        NetworkManager.signUp(email: signUpView.emailTextField.text!, username: "Ahhh", password: signUpView.passwordTextField.text!, location: CLLocation(latitude: CLLocationDegrees(exactly: 35.6)!, longitude: CLLocationDegrees(exactly: 39.6)!)) { (User) in
            print(User)
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
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


