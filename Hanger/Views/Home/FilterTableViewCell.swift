//
//  FilterTableViewCell.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/14/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    var titleLabel: UILabel!
    var collectionView: UICollectionView!
    
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
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 18 * Global.ScaleFactor, weight: .bold)
        contentView.addSubview(titleLabel)
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView)
        
    }
    
    func configureCell(labelText: String) {
        self.titleLabel.text = labelText
        setupConstraints()
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(32 * Global.ScaleFactor)
            make.centerX.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(24 * Global.ScaleFactor)
            make.height.equalToSuperview().multipliedBy(0.35)
            make.bottom.equalToSuperview().offset(-32 * Global.ScaleFactor)
        }
        
        
    }
    
}



