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
    var userManager: UserManager!
    var networkManager: NetworkManager!
    
    init(userManager: UserManager = .currentUser(), networkManager: NetworkManager = .shared()) {
        self.userManager = userManager
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changePasswordView = ChangePasswordView()
        changePasswordView.changePasswordButton.addTarget(self, action: #selector(changePasswordButtonPressed), for: .touchUpInside)
        changePasswordView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(changePasswordView)
        changePasswordView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        setupTextFieldControl() //Must be called after creation of changePasswordView
        
    }

    @objc func changePasswordButtonPressed() {
        var currentPass: String = ""
        var newPass: String = ""
        do {
            currentPass = try changePasswordView.currentPasswordTextField.text!.validateText(validationType: .password)
            newPass = try changePasswordView.newPasswordTextField.text!.validateText(validationType: .password)
        } catch {
            self.present(HelpfulFunctions.createAlert(for: (error as! MessageError).message), animated: true, completion: nil)
            return
        }
        let updatePasswordTask = UpdatePasswordTask(userID: userManager.user.id, currentPassword: currentPass, newPassword: newPass)
        updatePasswordTask.execute(in: self.networkManager).then { () in
            let okPressed: (UIAlertAction) -> Void = { _ in self.navigationController?.popViewController(animated: true)}
            self.present(HelpfulFunctions.createAlert(for: "Password Successfully Changed", okHandler: okPressed), animated: true, completion: nil)
            }.catch { (error) in
                var errorText = ""
                if let msgError = error as? MessageError {errorText = msgError.message} else {errorText = "Error"}
                self.present(HelpfulFunctions.createAlert(for: errorText), animated: true, completion: nil)
        }
        
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
