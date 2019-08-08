//
//  ChatView.swift
//  Carbon38
//
//  Created by dev on 6/6/19.
//  Copyright © 2019 Carbon38. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    lazy var label: SelectableLabel = {
        let label = SelectableLabel()
//        label.adjustsFontSizeToFitWidth = true
//        label.minimumScaleFactor = 0.8 
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20 * Global.ScaleFactor)
        return label
    }()
    
    lazy var chatImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var messageBackgroundView: UIView = {
        let messageBackgroundView = UIView()
        messageBackgroundView.clipsToBounds = true
        messageBackgroundView.layer.cornerRadius = 12
        messageBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        return messageBackgroundView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        initalSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initalSetup() { 
        
        contentView.addSubview(messageBackgroundView)
        
        contentView.addSubview(label)

        contentView.addSubview(chatImageView)
        
    }
    
    func configureCell(chatMessage: ChatMessage) {
        label.text = nil
        chatImageView.image = nil
        
        switch chatMessage.messageType {
        case .photo: configureCellForImage(isMyMessage: chatMessage.isMyMessage, image: chatMessage.photo ?? UIImage(named: "accounticon")!)
        case .text: configureCellForText(labelText: chatMessage.text ?? "", isMyMessage: chatMessage.isMyMessage)
        }
    }
    
    private func configureCellForText(labelText: String, isMyMessage: Bool) {
        label.isHidden = false
        chatImageView.isHidden = true
        label.text = labelText
        messageBackgroundView.backgroundColor = isMyMessage ? #colorLiteral(red: 0.1881278455, green: 0.8716738224, blue: 0.9487171769, alpha: 1) : UIColor(white: 0.9, alpha: 1)
        setupMessageConstraints(isMyMessage: isMyMessage)
    }
    
    private func configureCellForImage(isMyMessage: Bool, image: UIImage) {
        chatImageView.isHidden = false
        label.isHidden = true
        messageBackgroundView.backgroundColor = isMyMessage ?  #colorLiteral(red: 0.1881278455, green: 0.8716738224, blue: 0.9487171769, alpha: 1) : UIColor(white: 0.9, alpha: 1)
        chatImageView.image = image
        setupImageConstraints(isMyMessage: isMyMessage)
    }
    
    
    private func setupMessageConstraints(isMyMessage: Bool) {
        let backgroundViewPadding = 16 * Global.ScaleFactor

        messageBackgroundView.snp.remakeConstraints { (make) in
            make.leading.equalTo(label.snp.leading).offset(-backgroundViewPadding * Global.ScaleFactor)
            make.trailing.equalTo(label.snp.trailing).offset(backgroundViewPadding * Global.ScaleFactor)
            make.top.equalTo(label.snp.top).offset(-backgroundViewPadding * Global.ScaleFactor)
            make.bottom.equalTo(label.snp.bottom).offset(backgroundViewPadding * Global.ScaleFactor)
        }
        
        
        label.snp.remakeConstraints { (make) in
            if !isMyMessage {
                make.leading.equalTo(contentView.snp.leading).offset(32 * Global.ScaleFactor)
            } else {
                make.trailing.equalTo(contentView.snp.trailing).offset(-32 * Global.ScaleFactor)
            }
            make.width.lessThanOrEqualTo(275 * Global.ScaleFactor)
            make.height.greaterThanOrEqualTo(1)
            make.top.equalTo(contentView.snp.top).offset(38 * Global.ScaleFactor)
            make.bottom.equalTo(contentView.snp.bottom).offset(-38 * Global.ScaleFactor)
        }
        
    }
    
    private func setupImageConstraints(isMyMessage: Bool) {
        let backgroundViewPadding = 16 * Global.ScaleFactor

        chatImageView.snp.remakeConstraints { (make) in
            if !isMyMessage {
                make.leading.equalToSuperview().offset(32 * Global.ScaleFactor)
            } else {
                make.trailing.equalToSuperview().offset(-32 * Global.ScaleFactor)
            }
            make.top.equalToSuperview().offset(38 * Global.ScaleFactor)
            make.bottom.equalToSuperview().offset(-38 * Global.ScaleFactor)
        }
        
        messageBackgroundView.snp.remakeConstraints { (make) in
            make.leading.equalTo(label.snp.leading).offset(-backgroundViewPadding * Global.ScaleFactor)
            make.trailing.equalTo(label.snp.trailing).offset(backgroundViewPadding * Global.ScaleFactor)
            make.top.equalTo(label.snp.top).offset(-backgroundViewPadding * Global.ScaleFactor)
            make.bottom.equalTo(label.snp.bottom).offset(backgroundViewPadding * Global.ScaleFactor)
        }
        
        
    }
    
}
