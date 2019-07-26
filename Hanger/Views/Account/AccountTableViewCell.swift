//
//  AccountTableViewCell.swift
//  Carbon38
//
//  Created by dev on 6/6/19.
//  Copyright © 2019 Carbon38. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .done
        textField.textColor = .gray
        textField.font = UIFont(name: "Helvetica", size: 18 * Global.ScaleFactor)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Helvetica", size: 18 * Global.ScaleFactor)
        return label
    }()
    
    lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "rightskinnyarrow"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var seperatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var seperatorLineView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        self.selectionStyle = .none
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        contentView.addSubview(seperatorLineView)

        contentView.addSubview(seperatorLineView2)
        
        contentView.addSubview(textField)
        
        contentView.addSubview(label)
        
        setupConstraints()
    }
    
    func configureCell(labelText: String) {
        label.text = labelText
        if labelText == "Password" {
            contentView.addSubview(arrowImageView)
            arrowImageView.snp.makeConstraints { (make) in
                make.trailing.equalToSuperview().offset(-32 * Global.ScaleFactor)
                make.centerY.equalToSuperview()
                make.width.height.equalTo(35 * Global.ScaleFactor)
            }
        }
        
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
    
    

