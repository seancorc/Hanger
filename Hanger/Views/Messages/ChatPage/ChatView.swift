//
//  ChatView.swift
//  Carbon38
//
//  Created by dev on 6/7/19.
//  Copyright © 2019 Carbon38. All rights reserved.
//

import UIKit
import SnapKit

class ChatView: UIView {
    var messageInputContainerView: UIView!
    var inputTextView: UITextView!
    var topBorderView: UIView!
    var tableView: UITableView!
    var sendButton: UIButton!
    var mediaButton: UIButton!
    let textViewInitalHeight: CGFloat = 64

    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        
        setupSubviews()
        self.bringSubviewToFront(inputTextView)
        self.bringSubviewToFront(sendButton)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupSubviews() {
        messageInputContainerView = UIView()
        messageInputContainerView.backgroundColor = .white
        addSubview(messageInputContainerView)
        
        inputTextView = UITextView()
        inputTextView.translatesAutoresizingMaskIntoConstraints = false
        inputTextView.isEditable = true
        inputTextView.textColor = .lightGray
        inputTextView.font = UIFont(name: "Helvetica", size: 18)
        inputTextView.text = "Enter Message..."
        messageInputContainerView.addSubview(inputTextView)
        
        sendButton = UIButton()
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.setBackgroundImage(UIImage(named: "sendicon"), for: .normal)
        messageInputContainerView.addSubview(sendButton)
        
        mediaButton = UIButton()
        mediaButton.translatesAutoresizingMaskIntoConstraints = false
        mediaButton.setBackgroundImage(UIImage(named: "mediaicon"), for: .normal)
        messageInputContainerView.addSubview(mediaButton)
        
        topBorderView = UIView()
        topBorderView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        messageInputContainerView.addSubview(topBorderView)
        
        
        tableView = UITableView(frame: UIApplication.shared.keyWindow?.frame ?? .zero, style: .grouped)
        tableView.separatorStyle = .none
        //Disabling tableview cell self-sizing for header and footers because it is not necesary and caused label positioning issues when sending message
        //Refrence - https://stackoverflow.com/questions/46246924/ios-11-floating-tableview-header/46257601#46257601
        self.tableView.estimatedSectionHeaderHeight = 0
        self.tableView.estimatedSectionFooterHeight = 0
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tableView.keyboardDismissMode = .interactive
        addSubview(tableView)
        
    
        setupConstraints()
        
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(messageInputContainerView.snp.top)
        }
        
        messageInputContainerView.snp.makeConstraints{ (make) in
            make.width.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(inputTextView.snp.height)
        }
        
        topBorderView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalTo(inputTextView.snp.top)
            make.height.equalTo(1)
        }
        
        inputTextView.snp.makeConstraints { (make) in
            make.leading.equalTo(mediaButton.snp.trailing).offset(12 * Global.ScaleFactor)
            make.trailing.equalTo(sendButton.snp.leading).offset(-8 * Global.ScaleFactor)
            make.bottom.equalToSuperview()
            make.height.equalTo(textViewInitalHeight * Global.ScaleFactor)
        }
        
        sendButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-12 * Global.ScaleFactor)
            make.width.height.equalTo((textViewInitalHeight - 20) * Global.ScaleFactor)
            make.bottom.equalToSuperview().offset(-8 * Global.ScaleFactor)
        }
        
        mediaButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(12 * Global.ScaleFactor)
            make.width.height.equalTo((textViewInitalHeight - 20) * Global.ScaleFactor)
            make.bottom.equalToSuperview().offset(-8 * Global.ScaleFactor)
        }
    }
    
    func updateConstraintsForKeyboard(amount: CGFloat) {
        messageInputContainerView.snp.remakeConstraints { (make) in
            make.width.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(amount)
            make.height.equalTo(inputTextView.snp.height)
        }
}
    

    
}
    
    

