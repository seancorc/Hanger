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
    var imagePicker: UIImagePickerController!
    var tableViewDataSourceAndDelegate = ChatTableViewDataSourceAndDelegate(chatMessages: [ChatMessage(text: "Yooooo duder", isMyMessage: true)])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
    
    func setupTableViewControl() {
        self.chatView.tableView.delegate = tableViewDataSourceAndDelegate
        self.chatView.tableView.dataSource = tableViewDataSourceAndDelegate
        self.chatView.tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: Global.CellID)
    }
    
    @objc func sendMessage() {
        if self.chatView.inputTextView.textColor != .lightGray &&  !self.chatView.inputTextView.text.isEmpty {
            let messageText = self.chatView.inputTextView.text ?? ""
            tableViewDataSourceAndDelegate.chatMessages.append(ChatMessage(text: messageText, isMyMessage: true))
            DispatchQueue.main.async {
                self.chatView.tableView.reloadData() //Must be called before scrollToRow
                self.chatView.tableView.layoutIfNeeded()
                self.chatView.tableView.scroll(to: .bottom, animated: true)
            }
            chatView.inputTextView.text = ""
            let textViewHeightConstraint = HelpfulFunctions.getViewConstraint(attribute: .height, view: chatView.inputTextView)
            textViewHeightConstraint?.constant = chatView.textViewInitalHeight
            UIView.animate(withDuration: 0.2) {
                self.chatView.layoutIfNeeded()
            }
        }
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


