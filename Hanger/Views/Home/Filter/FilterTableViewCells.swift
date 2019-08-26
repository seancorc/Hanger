//
//  FilterTableViewCell.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/14/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    static let titleFontSize = 18 * Global.ScaleFactor
    static let allFontSize = 16 * Global.ScaleFactor
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica-Bold", size: FilterTableViewCell.titleFontSize)
        return label
    }()
    
    lazy var allLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: FilterTableViewCell.allFontSize)
        return label
    }()
    
    lazy var allSwitch: UISwitch = {
        let allSwitch = UISwitch()
        allSwitch.translatesAutoresizingMaskIntoConstraints = false
        allSwitch.isOn = true
        allSwitch.transform = CGAffineTransform(scaleX: Global.ScaleFactor, y: Global.ScaleFactor)
        return allSwitch
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.alpha = 0.5
        cv.isUserInteractionEnabled = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMoveToSuperview() {
        
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(collectionView)
        
        contentView.addSubview(allLabel)
        
        contentView.addSubview(allSwitch)
        
        setupConstraints()
    }
    
    func configureCell(labelText: String, allLabelText: String) {
        self.titleLabel.text = labelText
        self.allLabel.text = allLabelText
    }
    
    func setupConstraints() {
        let padding = 16 * Global.ScaleFactor
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(padding)
            make.centerX.equalToSuperview()
        }
        
        allLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(allSwitch.snp.centerY)
            make.trailing.equalTo(allSwitch.snp.leading).offset(-padding / 2)
        }
        
        allSwitch.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(padding / 2)
            make.centerX.equalToSuperview().offset(padding * 1.5)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(allSwitch.snp.bottom).offset(padding) //For automatic TV dimension
            make.height.equalToSuperview().multipliedBy(0.35)
            make.bottom.equalToSuperview().offset(-padding * 2) //For automatic TV dimension
            make.centerX.equalToSuperview()
        }
        
        
    }
    
}

class FilterPriceTableViewCell: UITableViewCell {
    static let titleFontSize = 18 * Global.ScaleFactor
    static let allFontSize = 16 * Global.ScaleFactor
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica-Bold", size: FilterTableViewCell.titleFontSize)
        return label
    }()
    
    lazy var allLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: FilterTableViewCell.allFontSize)
        return label
    }()
    
    lazy var allSwitch: UISwitch = {
        let allSwitch = UISwitch()
        allSwitch.translatesAutoresizingMaskIntoConstraints = false
        allSwitch.isOn = true
        allSwitch.transform = CGAffineTransform(scaleX: Global.ScaleFactor, y: Global.ScaleFactor)
        return allSwitch
    }()
    
    lazy var keyboardDoneButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 28/255, green: 183/255, blue: 1, alpha: 1)
        button.setTitle("Done", for: .normal)
        return button
    }()
    
    lazy var minPriceTextField: NiceSpacingTextField = {
        let textField = NiceSpacingTextField(selectable: false)
        textField.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textField.alpha = 0.4
        textField.isUserInteractionEnabled = false
        textField.keyboardType = UIKeyboardType.numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Min Price"
        textField.font = UIFont(name: "Helvetica", size: 24 * Global.ScaleFactor)
        return textField
    }()
    
    lazy var dash: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.alpha = 0.4
        return view
    }()
    
    lazy var maxPriceTextField: NiceSpacingTextField = {
        let textField = NiceSpacingTextField(selectable: false)
        textField.keyboardType = UIKeyboardType.numberPad
        textField.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textField.alpha = 0.4
        textField.isUserInteractionEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Max Price"
        textField.font = UIFont(name: "Helvetica", size: 24 * Global.ScaleFactor)
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMoveToSuperview() {
        
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(allLabel)
        
        contentView.addSubview(allSwitch)
        
        minPriceTextField.inputAccessoryView = keyboardDoneButton
        contentView.addSubview(minPriceTextField)
        
        contentView.addSubview(dash)
        
        maxPriceTextField.inputAccessoryView = keyboardDoneButton
        contentView.addSubview(maxPriceTextField)
        
        setupConstraints()
    }
    
    override func layoutSubviews() {
        keyboardDoneButton.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height * 0.2)
    }
    
    func configureCell(labelText: String, allLabelText: String) {
        self.titleLabel.text = labelText
        self.allLabel.text = allLabelText
    }
    
    func setupConstraints() {
        let padding = 16 * Global.ScaleFactor
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(padding)
            make.centerX.equalToSuperview()
        }
        
        allLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(allSwitch.snp.centerY)
            make.trailing.equalTo(allSwitch.snp.leading).offset(-padding / 2)
        }
        
        allSwitch.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(padding / 2)
            make.centerX.equalToSuperview().offset(padding * 1.5)
        }
        
        minPriceTextField.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalTo(contentView.snp.centerX).offset(-padding)
            make.height.equalToSuperview().multipliedBy(0.35)
            make.top.equalTo(allSwitch.snp.bottom).offset(padding) //For automatic TV dimension
            make.bottom.equalToSuperview().offset(-padding * 2) //For automatic TV dimension
        }
        
        dash.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(minPriceTextField.snp.centerY)
            make.width.equalTo(padding)
            make.height.equalTo(1)
        }
        
        maxPriceTextField.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-padding)
            make.leading.equalTo(contentView.snp.centerX).offset(padding)
            make.height.equalToSuperview().multipliedBy(0.35)
            make.top.equalTo(allSwitch.snp.bottom).offset(padding) //For automatic TV dimension
            make.bottom.equalToSuperview().offset(-padding * 2) //For automatic TV dimension
        }
    
    }
    
}



