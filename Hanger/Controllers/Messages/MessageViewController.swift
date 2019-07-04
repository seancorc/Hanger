//
//  ChatViewController.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/2/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit


class Chat {
    var chatName: String!
    var previewMessage: String!
    
    init(cn: String, cm: String) {
        chatName = cn
        previewMessage = cm
    }
}

class MessageViewController: UIViewController {
    var chatName: String!
    var previewMessage: String!
    var messageView: MessageView!
    var editButton: UIBarButtonItem!
    var doneButton: UIBarButtonItem!
    static var hardCodedChats = [Chat(cn: "Josh Rosen - Red Nike Hat", cm: "See you soon!"), Chat(cn: "Rowanda Smith - Purple Sweatpants", cm: "I'm intrested in your purple sweaties"),Chat(cn: "George Harden - Yolo braclet", cm: "YOLO AM I RIGHT, LMAO!")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        
        
        messageView = MessageView()
        view.addSubview(messageView)
        self.messageView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
        
        setupTableViewControl() //Must be called after creation of messageView
        
    }
    
    
}

//Tableview control
extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableViewControl() {
        self.messageView.tableView.delegate = self
        self.messageView.tableView.dataSource = self
        self.messageView.tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: "cellID")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageViewController.hardCodedChats.count
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 * Global.ScaleFactor
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !tableView.isEditing {
            tableView.deselectRow(at: indexPath, animated: true) //For UI purposes
            let chat = MessageViewController.hardCodedChats[indexPath.row]
            let chatController = ChatViewController()
            chatController.navigationItem.title = chat.chatName
            tabBarController?.tabBar.isHidden = true
            
            chatController.hardCodedMessages = HardCodedChatMessages.conversationArray[indexPath.row]
            
            self.navigationController?.pushViewController(chatController, animated: true)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            MessageViewController.hardCodedChats.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.messageView.tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! MessageTableViewCell
        let chat = MessageViewController.hardCodedChats[indexPath.row]
        cell.configureCell(chatName: chat.chatName, chatImage: #imageLiteral(resourceName: "sellerimage"), dateLastActive:  Date(timeIntervalSinceNow: -86400.0 * Double(indexPath.row)).shortDate, previewMessage: chat.previewMessage)
        return cell
    }
    
    
    
}

//NavBar setup & functionality
extension MessageViewController {
    
    func setupNavBar() {
        navigationItem.title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        
        self.editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonPressed))
        self.doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editButtonPressed))
        navigationItem.leftBarButtonItem = editButton
    }
    
    @objc func editButtonPressed() {
        UIView.animate(withDuration: 0.3, animations: {
            self.messageView.tableView.isEditing = !self.messageView.tableView.isEditing
        })
        navigationItem.leftBarButtonItem = self.messageView.tableView.isEditing ? doneButton : editButton
    }
    
    
}
