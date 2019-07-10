//
//  AccountViewController.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/3/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    var accountView: AccountView!
    var imagePicker: UIImagePickerController!
    let hardcodedInfo = ["Josh Smith", "Jsmith@gmail.com", "310-556-2143", ""]
    var keyboardFrame: CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        accountView = AccountView()
        accountView.logoutButton.addTarget(self, action: #selector(logoutPressed), for: UIControl.Event.touchUpInside)
        accountView.profilePictureButton.addTarget(self, action: #selector(changePicture), for: .touchUpInside)
        self.view.addSubview(accountView)
        self.accountView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
        
        
        setupTableViewControl() //Must be called after accountView is created
        
        //Handle keyboard showing - needs to be refined along with constraints for tableview
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            let isKeyboardOpen = notification.name == UIResponder.keyboardWillShowNotification
            
            let safeAreaOffset = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            accountView.updateConstraintsForKeyboard(amount: isKeyboardOpen ? (safeAreaOffset - keyboardFrame.height) : 0)
            
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func logoutPressed() {
        let loginViewController = LoginViewController()
        self.present(loginViewController, animated: true, completion: nil)
        
    }

    
    @objc func changePicture() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    
}

extension AccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            accountView.profilePictureButton.setImage(image, for: .normal) //Temporary solution - Backend needed to act properly
        }
        dismiss(animated: true, completion: nil)
    }
}

extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableViewControl() {
        self.accountView.tableView.delegate = self
        self.accountView.tableView.dataSource = self
        self.accountView.tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: Global.CellID)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hardcodedInfo.count
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 * Global.ScaleFactor
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            present(ChangePasswordViewController(), animated: true, completion: nil)
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.accountView.tableView.dequeueReusableCell(withIdentifier: Global.CellID, for: indexPath) as! AccountTableViewCell
        cell.tag = indexPath.row //Must be assigned before setup called - tells top cell to have a seperator line
        var labelText: String = ""
        switch indexPath.row {
        case 0: labelText = "Name"
        case 1: labelText = "Email"
        case 2: labelText = "Phone Number"
        case 3: labelText = "Password"; cell.textField.allowsEditingTextAttributes = false
        default: labelText = "Error"
        }
        cell.configureCell(labelText: labelText)
        cell.textField.delegate = self
        cell.textField.text = hardcodedInfo[indexPath.row]
        return cell
    }
    
    
    
}

extension AccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //Drop keyboard
        return true
    }
    
}

extension AccountViewController {
    func setupNavBar() {
        //Making nav bar transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
}
