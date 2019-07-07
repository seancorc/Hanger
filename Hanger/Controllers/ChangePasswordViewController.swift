//
//  ChangePasswordViewController.swift
//  Carbon38
//
//  Created by dev on 6/18/19.
//  Copyright © 2019 Carbon38. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    var changePasswordView: ChangePasswordView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changePasswordView = ChangePasswordView()
        changePasswordView.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        changePasswordView.changePasswordButton.addTarget(self, action: #selector(changePasswordButtonPressed), for: .touchUpInside)
        changePasswordView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(changePasswordView)
        changePasswordView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        setupTextFieldControl() //Must be called after creation of changePasswordView
        
    }
    
    @objc func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }

    @objc func changePasswordButtonPressed() {
        print("change pass")
    }
    
    
}

extension ChangePasswordViewController: UITextFieldDelegate {
    func setupTextFieldControl() {
        changePasswordView.currentPasswordTextField.delegate = self
        changePasswordView.newPasswordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //Drop keyboard
        return true
    }
}
