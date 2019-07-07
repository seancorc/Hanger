//
//  ChatView.swift
//  Carbon38
//
//  Created by dev on 6/6/19.
//  Copyright © 2019 Carbon38. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    var chatNameLabel: UILabel!
    var label: SelectableLabel!
    var chatImageView: UIImageView!
    var messageBackgroundView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        initalSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initalSetup() {
        
        chatNameLabel = UILabel()
        chatNameLabel.translatesAutoresizingMaskIntoConstraints = false
        chatNameLabel.textColor = .darkGray
        chatNameLabel.font = UIFont(name: "Helvetica", size: 12)
        contentView.addSubview(chatNameLabel)
        
        messageBackgroundView = UIView() //Must be added before label so that label text is shown on top
        messageBackgroundView.clipsToBounds = true
        messageBackgroundView.layer.cornerRadius = 12
        messageBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(messageBackgroundView)
        
        label = SelectableLabel()
        label.numberOfLines = 0 //0 means it automatically adjust to amount of lines needed
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Helvetica", size: 18)
        contentView.addSubview(label)
        
        chatImageView = UIImageView()
        chatImageView.translatesAutoresizingMaskIntoConstraints = false
        chatImageView.contentMode = .scaleAspectFit
        contentView.addSubview(chatImageView)
        
    }
    
    func configureCell(chatMessage: ChatMessage, chatNameLabelText: String) {
        switch chatMessage.messageType {
        case .photo: configureCellForImage(isMyMessage: chatMessage.isMyMessage, image: chatMessage.photo)
        case .text: configureCellForText(labelText: chatMessage.text, isMyMessage: chatMessage.isMyMessage, chatNameLabelText: chatNameLabelText)
        }
    }
    
    private func configureCellForText(labelText: String, isMyMessage: Bool, chatNameLabelText: String) {
        chatImageView.image = nil
        messageBackgroundView.backgroundColor = isMyMessage ? #colorLiteral(red: 1, green: 0.6321351786, blue: 0.484305679, alpha: 1) : .white
        label.text = labelText
        if !isMyMessage { //Only put name label if message is incoming
            chatNameLabel.text = chatNameLabelText
        } else {
            chatNameLabel.text = ""
        }
        
        setupMessageConstraints(isMyMessage: isMyMessage)
    }
    
    private func configureCellForImage(isMyMessage: Bool, image: UIImage?) {
        label.text = nil
        messageBackgroundView.backgroundColor = isMyMessage ? #colorLiteral(red: 1, green: 0.6321351786, blue: 0.484305679, alpha: 1) : .white
        chatNameLabel.text = nil
        if let chatImage = image {
            chatImageView.image = chatImage
            setupImageConstraints(isMyMessage: isMyMessage)
        }
    }
    
    
    private func setupMessageConstraints(isMyMessage: Bool) {
        
        chatNameLabel.snp.remakeConstraints { (make) in
            make.leading.equalTo(label.snp.leading)
            make.bottom.equalTo(messageBackgroundView.snp.top)
        }
        
        messageBackgroundView.snp.remakeConstraints { (make) in
            make.leading.equalTo(label.snp.leading).offset(-16 * Global.ScaleFactor)
            make.trailing.equalTo(label.snp.trailing).offset(16 * Global.ScaleFactor)
            make.top.equalTo(label.snp.top).offset(-16 * Global.ScaleFactor)
            make.bottom.equalTo(label.snp.bottom).offset(16 * Global.ScaleFactor)
        }
        
        
        label.snp.remakeConstraints { (make) in
            if !isMyMessage {
                make.leading.equalTo(contentView.snp.leading).offset(28 * Global.ScaleFactor) //If go any higher than 28 there will be issues with small messages having small content sizes causing the constraints to 'squish' the label 
            } else {
                make.trailing.equalTo(contentView.snp.trailing).offset(-28 * Global.ScaleFactor)
            }
            make.width.lessThanOrEqualTo(250 * Global.ScaleFactor)
            make.top.equalTo(contentView.snp.top).offset(28 * Global.ScaleFactor)
            make.bottom.equalTo(contentView.snp.bottom).offset(-28 * Global.ScaleFactor)
        }
        
    }
    
    private func setupImageConstraints(isMyMessage: Bool) {
        
        chatImageView!.snp.remakeConstraints { (make) in
            if !isMyMessage {
                make.leading.equalToSuperview().offset(32 * Global.ScaleFactor)
            } else {
                make.trailing.equalToSuperview().offset(-32 * Global.ScaleFactor)
            }
            make.top.equalToSuperview().offset(32 * Global.ScaleFactor)
            make.bottom.equalToSuperview().offset(-32 * Global.ScaleFactor)
        }
        
        messageBackgroundView.snp.remakeConstraints { (make) in
            make.leading.equalTo(chatImageView!.snp.leading).offset(-16 * Global.ScaleFactor)
            make.trailing.equalTo(chatImageView!.snp.trailing).offset(16 * Global.ScaleFactor)
            make.top.equalTo(chatImageView!.snp.top).offset(-16 * Global.ScaleFactor)
            make.bottom.equalTo(chatImageView!.snp.bottom).offset(16 * Global.ScaleFactor)
        }
        
        
    }
    
}
