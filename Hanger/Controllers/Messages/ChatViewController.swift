//
//  ChatViewController.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/3/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    var chatView: ChatView!
    var bottomConstraint: NSLayoutConstraint!
    var cellHeights: [IndexPath: CGFloat] = [:] //Used to store cellHeights in cellWillDisplayAt to fix bug caused by AutomaticDimension and a poor estimated height when sending message
    var imagePicker: UIImagePickerController!
    var hardCodedMessages: [[ChatMessage]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        chatView = ChatView()
        view.addSubview(chatView)
        self.chatView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
        
        setupTableViewControl() //Must be called after chatview is created
        
        chatView.inputTextView.delegate = self
        
        //Keyboard handling
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        chatView.sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        chatView.mediaButton.addTarget(self, action: #selector(mediaButtonPressed), for: .touchUpInside)
        
        if let bottomIndexPath = HelpfulFunctions.getBottomMostTableViewIndexPath(tableView: self.chatView.tableView) {
            DispatchQueue.main.async { //Needed to scroll all the way to bottom
                self.chatView.tableView.scrollToRow(at: bottomIndexPath, at: .bottom, animated: false)
            }
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            let isKeyboardOpen = notification.name == UIResponder.keyboardWillShowNotification
            let safeAreaOffset = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            chatView.updateConstraintsForKeyboard(amount: isKeyboardOpen ? (safeAreaOffset - keyboardFrame.height) : 0)
            
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            })
        }
        
    }
    
    @objc func mediaButtonPressed() {
        if chatView.inputTextView.text == "Enter Message..." {chatView.inputTextView.text = ""}
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func sendMessage() {
        if self.chatView.inputTextView.textColor != .lightGray {
            let messageText = self.chatView.inputTextView.text!
            hardCodedMessages[numberOfSections(in: self.chatView.tableView) - 1].append(ChatMessage(text: messageText, isMyMessage: true, date: Date().shortDate, messageType: .text))
            self.chatView.tableView.reloadData() //Must be called before scrollToRow
            if let bottomIndexPath = HelpfulFunctions.getBottomMostTableViewIndexPath(tableView: self.chatView.tableView) {
                self.chatView.tableView.scrollToRow(at: bottomIndexPath, at: .none, animated: true)
            }
            chatView.inputTextView.text = ""
            let textViewHeightConstraint = HelpfulFunctions.getViewConstraint(attribute: .height, view: chatView.inputTextView)
            textViewHeightConstraint?.constant = chatView.textViewInitalHeight * Global.ScaleFactor
            chatView.layoutIfNeeded()
        }
    }
    
}


//Tableview control
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableViewControl() {
        self.chatView.tableView.delegate = self
        self.chatView.tableView.dataSource = self
        self.chatView.tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: Global.CellID)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return hardCodedMessages.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dateLabel = DateMessageHeaderView()
        dateLabel.setupLabel(date: Date().shortDate)
        let containerView = UIView()
        containerView.addSubview(dateLabel)
        containerView.bringSubviewToFront(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.center.equalTo(containerView.snp.center)
        }
        return containerView
    }
    
    //Used to obtain accurate estimated row height ~ without this scrollToRowAt looks really jumpy and glitchy (https://stackoverflow.com/questions/28244475/reloaddata-of-uitableview-with-dynamic-cell-heights-causes-jumpy-scrolling)
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath] ?? 150
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50 * Global.ScaleFactor
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hardCodedMessages[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatView.tableView.dequeueReusableCell(withIdentifier: Global.CellID, for: indexPath) as! ChatTableViewCell
        let chatMessage = hardCodedMessages[indexPath.section][indexPath.row]
        switch chatMessage.messageType {
        case .photo: cell.configureCell(chatMessage: chatMessage, chatNameLabelText: "")
        case .text:
            switch indexPath {
            case [0,0]:
                if navigationItem.title == "West Coast District" || navigationItem.title == "Job Postings" {
                    cell.configureCell(chatMessage: chatMessage, chatNameLabelText: "C38 Admin")
                } else {
                    cell.configureCell(chatMessage: chatMessage, chatNameLabelText: "")
                }
            default:
                if navigationItem.title == "West Coast District" || navigationItem.title == "Job Postings" {
                    cell.configureCell(chatMessage: chatMessage, chatNameLabelText: MessageViewController.hardCodedChats[(indexPath.row + 3) % MessageViewController.hardCodedChats.count].chatName)
                } else {
                    cell.configureCell(chatMessage: chatMessage, chatNameLabelText: "")
                }
            }
        }
        
        return cell
    }
    
}

//TextView Control
extension ChatViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = .black
        }
        if let bottomIndexPath = HelpfulFunctions.getBottomMostTableViewIndexPath(tableView: self.chatView.tableView) {
            self.chatView.tableView.scrollToRow(at: bottomIndexPath, at: .bottom, animated: true)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = .lightGray
            textView.text = "Enter Message..."
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        handleDynamicTextViewHeight(textView: textView)
    }
    
    
    private func handleDynamicTextViewHeight(textView: UITextView) {
        let size = CGSize(width: textView.frame.size.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        let heightConstraint: NSLayoutConstraint? = HelpfulFunctions.getViewConstraint(attribute: .height, view: textView)
        if estimatedSize.height >= 150 {
            heightConstraint?.constant = 150
            textView.isScrollEnabled = true
        } else {
            textView.isScrollEnabled = false
            heightConstraint?.constant = (estimatedSize.height > heightConstraint?.constant ?? 0) ? estimatedSize.height : heightConstraint?.constant ?? 0
        }
    }
}

//ChatImagePickerControll
extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: {
            if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                //Resizing image
                let newSize = CGSize(width: self.chatView.inputTextView.frame.width, height: UIScreen.main.bounds.height / 3)
                UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
                image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
                let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
                
                self.hardCodedMessages[self.numberOfSections(in: self.chatView.tableView) - 1].append(ChatMessage(text: "photoMesssage", isMyMessage: true, date: Date().shortDate, messageType: .photo, photo: newImage))
                self.chatView.tableView.reloadData() //Must be called before scrollToRow
                if let bottomIndexPath = HelpfulFunctions.getBottomMostTableViewIndexPath(tableView: self.chatView.tableView) {
                    self.chatView.tableView.scrollToRow(at: bottomIndexPath, at: .none, animated: true)
                }
                self.chatView.layoutIfNeeded()
            }
        } )
        
    }
    
    
}

