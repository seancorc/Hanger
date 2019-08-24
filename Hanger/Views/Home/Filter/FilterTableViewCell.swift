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
        self.selectionStyle = .none
        
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



