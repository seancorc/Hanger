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
        imageView.layer.cornerRadius = (self.frame.height - 20) / 2
        return imageView
    }()
    
    lazy var chatLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16 * Global.ScaleFactor)
        return label
    }()
    
    lazy var previewMessageLabel: UILabel = {
        let previewMessageLabel = UILabel()
        previewMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        previewMessageLabel.textColor = .gray
        previewMessageLabel.font = UIFont.systemFont(ofSize: 16 * Global.ScaleFactor)
        return previewMessageLabel
    }()
    
    lazy var seperatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        contentView.addSubview(chatImageView)
        
        contentView.addSubview(chatLabel)
        
        contentView.addSubview(previewMessageLabel)
        
        contentView.addSubview(seperatorLineView)
        }
    
    func configureCell(chatName: String, chatImage: UIImage = UIImage(named: "accounticon")!, previewMessage: String) {
        chatLabel.text = chatName
        chatImageView.image = chatImage
        previewMessageLabel.text = previewMessage
        setupConstraints()
        }
    
    func setupConstraints() {
        
        seperatorLineView.snp.makeConstraints { (make) in
            make.bottom.equalTo(contentView.snp.bottom)
            make.leading.equalTo(chatImageView.snp.leading).offset(self.frame.height - 20)
            make.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        
        chatImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.width.height.equalTo(self.frame.height - 20)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        chatLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(chatImageView.snp.trailing).offset(16)
            make.width.lessThanOrEqualTo(UIScreen.main.bounds.width - 200)
            make.centerY.equalTo(self.snp.centerY).offset(-16)
        }
        
        previewMessageLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(chatImageView.snp.trailing).offset(16)
            make.width.lessThanOrEqualTo(UIScreen.main.bounds.width - 100)
            make.centerY.equalTo(self.snp.centerY).offset(16)
        }
        
    }
}


