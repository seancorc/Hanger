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
    lazy var messageInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var inputTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = true
        textView.textColor = .lightGray
        textView.font = UIFont(name: "Helvetica", size: 18)
        textView.text = "Enter Message..."
        return textView
    }()
    
    var topBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.estimatedSectionHeaderHeight = 0
        tv.estimatedSectionFooterHeight = 0
        tv.allowsSelection = false
        tv.backgroundColor = .white
        tv.keyboardDismissMode = UITableView.KeyboardDismissMode.onDrag
        return tv
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "sendicon"), for: .normal)
        return button
    }()
    
    lazy var mediaButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "mediaicon"), for: .normal)
        return button
    }()
    
    let textViewInitalHeight: CGFloat = 64 * Global.ScaleFactor

    
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        addSubview(messageInputContainerView)
        
        messageInputContainerView.addSubview(inputTextView)
        
        messageInputContainerView.addSubview(sendButton)
        
        messageInputContainerView.addSubview(mediaButton)
        
        messageInputContainerView.addSubview(topBorderView)
        
        addSubview(tableView)
        
        self.backgroundColor = .white
        self.bringSubviewToFront(inputTextView)
        self.bringSubviewToFront(sendButton)
        
        setupConstraints()
    }
    
    
    func setupConstraints() {
        let buttonPadding = 12 * Global.ScaleFactor
        
        tableView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(messageInputContainerView.snp.top)
        }
        
        messageInputContainerView.snp.makeConstraints{ (make) in
            make.leading.trailing.equalToSuperview()
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
            make.height.equalTo(textViewInitalHeight)
        }
        
        sendButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-buttonPadding)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
            make.width.equalTo(sendButton.snp.height)
            make.bottom.equalToSuperview().offset(-buttonPadding)
        }
        
        mediaButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(buttonPadding)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
            make.width.equalTo(mediaButton.snp.height)
            make.bottom.equalToSuperview().offset(-buttonPadding)
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
    
    

