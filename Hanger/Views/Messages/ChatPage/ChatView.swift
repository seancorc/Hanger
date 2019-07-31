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
        tv.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tv.keyboardDismissMode = .interactive
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
    
    let textViewInitalHeight: CGFloat = 64
    
    
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
    
    

