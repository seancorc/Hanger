//
//  AccountTableViewCell.swift
//  Carbon38
//
//  Created by dev on 6/6/19.
//  Copyright © 2019 Carbon38. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    var textField: UITextField!
    var label: UILabel!
    var passwordArrow: UIImageView!
    var seperatorLineView: UIView!
    var seperatorLineView2: UIView!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        self.selectionStyle = .none
        initalSetup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initalSetup() {
        
        
        seperatorLineView = UIView()
        seperatorLineView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        seperatorLineView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(seperatorLineView)
        seperatorLineView2 = UIView()
        seperatorLineView2.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        seperatorLineView2.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(seperatorLineView2)
        
        textField = UITextField()
        textField.returnKeyType = .done
        textField.textColor = .gray
        textField.font = UIFont(name: "Helvetica", size: 18 * Global.ScaleFactor)
        textField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textField)
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Helvetica", size: 18 * Global.ScaleFactor)
        contentView.addSubview(label)
        
        passwordArrow = UIImageView()
        passwordArrow.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureCell(labelText: String) {
        passwordArrow.image = nil
        label.text = nil
        textField.text = nil
        label.text = labelText
        if labelText == "Password" {
            passwordArrow.image = UIImage(named: "arrow")
            contentView.addSubview(passwordArrow)
            passwordArrow.snp.makeConstraints { (make) in
                make.trailing.equalToSuperview().offset(-32 * Global.ScaleFactor)
                make.centerY.equalToSuperview()
                make.width.height.equalTo(Global.BackButtonSize)
            }
        }
        
        setupConstraints()
    }
    
    func setupConstraints() {
        if self.tag == 0 { //Makes the top cell have a seperator line
        seperatorLineView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(0.5)
        }
        }
        
        seperatorLineView2.snp.makeConstraints { (make) in
            make.bottom.equalTo(contentView.snp.bottom)
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(0.5)
        }
        
        
        textField.snp.makeConstraints { (make) in
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.width.lessThanOrEqualTo(self.frame.width / 1.5)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        label.snp.makeConstraints { (make) in
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        
    }
    
}
    
    

