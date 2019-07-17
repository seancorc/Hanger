//
//  AccountViewController.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/3/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

/*
 ToDos:
 1. Check if changes made to email and username are valid
 2. Optimize how much calls to the backend are being made (check if anything has actually changed rather than just if user entered editing mode)
 **/
class AccountViewController: UIViewController {
    var accountView: AccountView!
    var imagePicker: UIImagePickerController!
    var keyboardFrame: CGRect!
    var userManager: UserManager!
    var networkManager: NetworkManager!
    var newEmail: String!
    var newUsername: String!
    var saveBarButton: UIBarButtonItem!
    
    init(userManager: UserManager = .currentUser(), networkManager: NetworkManager = .shared()) {
        super.init(nibName: nil, bundle: nil)
        self.userManager = userManager
        self.networkManager = networkManager
        self.newEmail = userManager.user.email
        self.newUsername = userManager.user.username
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        self.userManager.user = nil
        HelpfulFunctions.signOutAnimation()
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 * Global.ScaleFactor
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            present(ChangePasswordViewController(), animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.accountView.tableView.dequeueReusableCell(withIdentifier: Global.CellID, for: indexPath) as! AccountTableViewCell
        cell.tag = indexPath.row //Must be assigned before setup called - tells top cell to have a seperator line
        var labelText: String = ""
        switch indexPath.row {
        case 0: labelText = "Username"; cell.textField.text = userManager.user.username;  cell.textField.tag = 0; cell.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        case 1: labelText = "Email"; cell.textField.text = userManager.user.email;  cell.textField.tag = 1; cell.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        case 2: labelText = "Password"; cell.textField.isUserInteractionEnabled = false
        default: labelText = "Error"
        }
        cell.configureCell(labelText: labelText)
        cell.textField.delegate = self
        return cell
    }
}

extension AccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //Drop keyboard
        return true
    }
    
    @objc func textFieldDidChange(_ sender: Any) {
        navigationItem.rightBarButtonItem = saveBarButton
        if let textField = sender as? UITextField {
            switch textField.tag {
            case 0: newUsername = textField.text
            case 1: newEmail = textField.text
            default: print("This shouldnt happen - editing text field in non editable cell")
            }
        }
    }
}

extension AccountViewController {
    func setupNavBar() {
        //Making nav bar transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        let saveButton = NiceSpacingButton()
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        saveButton.setupButton(title: "Save", backgroundColor: #colorLiteral(red: 0.4360119624, green: 0.6691286069, blue: 1, alpha: 1))
        saveBarButton = UIBarButtonItem(customView: saveButton)
        
    }
    
    @objc func saveButtonPressed() {
        do {
            try self.newEmail.validateText(validationType: .email)
            try self.newUsername.validateText(validationType: .username)
        } catch {
            present(HelpfulFunctions.createAlert(for: (error as! MessageError).message), animated: true, completion: nil)
            return
        }
        let updateInfoTask = UpdateUserInformationTask(previousEmail: self.userManager.user.email, newEmail: self.newEmail, previousUsername: self.userManager.user.username, newUsername: self.newUsername)
        updateInfoTask.execute(in: self.networkManager) { (user, responseError) in
            if let err = responseError {
                self.present(HelpfulFunctions.createAlert(for: err.message), animated: true, completion: nil)
                return
            }
            self.userManager.user.email = self.newEmail
            self.userManager.user.username = self.newUsername
            let alert = HelpfulFunctions.createAlert(for: "Changes Saved")
            self.present(alert, animated: true, completion: nil)
            self.navigationItem.rightBarButtonItem = nil
        }
    }
}

