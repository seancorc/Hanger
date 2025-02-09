//
//  MesssageTableViewCell.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/3/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    lazy var chatImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var chatLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Helvetica", size: 18 * Global.ScaleFactor)
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.textColor = .gray
        timeLabel.font = UIFont(name: "Helvetica", size: 18 * Global.ScaleFactor)
        return timeLabel
    }()
    
    lazy var previewMessageLabel: UILabel = {
        let previewMessageLabel = UILabel()
        previewMessageLabel.numberOfLines = 2
        previewMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        previewMessageLabel.textColor = .gray
        previewMessageLabel.font = UIFont(name: "Helvetica", size: 18 * Global.ScaleFactor)
        return previewMessageLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        chatImageView.layer.cornerRadius = frame.height / 8
    }
    
    func setup() {
        contentView.addSubview(chatImageView)
        
        contentView.addSubview(chatLabel)
        
        contentView.addSubview(previewMessageLabel)
        
        contentView.addSubview(timeLabel)
        }
    
    func configureCell(chatName: String, chatImage: UIImage = UIImage(named: "accounticon")!, previewMessage: String, timeLabelText: String) {
        chatLabel.text = chatName
        chatImageView.image = chatImage
        previewMessageLabel.text = previewMessage
        timeLabel.text = timeLabelText
        setupConstraints()
        }
    
    func setupConstraints() {
        let imagePadding = 16 * Global.ScaleFactor
        let labelPadding = 16 * Global.ScaleFactor
        
        chatImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(contentView.snp.leading).offset(imagePadding)
            make.width.height.equalTo(frame.height - imagePadding)
            make.centerY.equalToSuperview()
        }
        
        chatLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(chatImageView.snp.trailing).offset(labelPadding)
            make.trailing.equalTo(timeLabel.snp.leading)
            make.top.equalTo(chatImageView.snp.top)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-labelPadding)
            make.top.equalTo(chatImageView.snp.top)
        }
        
        previewMessageLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(chatImageView.snp.trailing).offset(labelPadding)
            make.trailing.equalToSuperview()
            make.top.equalTo(chatLabel.snp.bottom)
        }
        
    }
}


