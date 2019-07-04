//
//  MesssageTableViewCell.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/3/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    var chatImageView: UIImageView!
    var chatLabel: UILabel!
    var previewMessageLabel: UILabel!
    var seperatorLineView: UIView!
    var timeLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        chatImageView = UIImageView()
        chatImageView.translatesAutoresizingMaskIntoConstraints = false
        chatImageView.clipsToBounds = true
        chatImageView.layer.cornerRadius = (self.frame.height - 20) / 2
        contentView.addSubview(chatImageView)
        
        chatLabel = UILabel()
        chatLabel.translatesAutoresizingMaskIntoConstraints = false
        chatLabel.textColor = .black
        chatLabel.font = UIFont.systemFont(ofSize: 20 * Global.ScaleFactor)
        contentView.addSubview(chatLabel)
        
        previewMessageLabel = UILabel()
        previewMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        previewMessageLabel.textColor = .gray
        previewMessageLabel.font = UIFont.systemFont(ofSize: 16 * Global.ScaleFactor)
        contentView.addSubview(previewMessageLabel)
        
        timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.textColor = .gray
        timeLabel.font = UIFont.systemFont(ofSize: 16 * Global.ScaleFactor)
        contentView.addSubview(timeLabel)
        
        seperatorLineView = UIView()
        seperatorLineView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        seperatorLineView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(seperatorLineView)
        
    }
    
    func configureCell(chatName: String,
                       chatImage: UIImage?,
                       dateLastActive: String,
                       previewMessage: String) {
        chatLabel.text = nil
        chatImageView.image = nil
        timeLabel.text = nil
        previewMessageLabel.text = nil
        
        chatLabel.text = chatName
        chatImageView.image = chatImage ?? UIImage(named: "profileicon")
        timeLabel.text = dateLastActive
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
        
        timeLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(self.snp.trailing).offset(-16)
            make.centerY.equalTo(self.snp.centerY).offset(-16)
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}


