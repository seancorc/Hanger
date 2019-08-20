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
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: FilterTableViewCell.titleFontSize, weight: .bold)
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
        
        setupConstraints()
    }
    
    func configureCell(labelText: String) {
        self.titleLabel.text = labelText
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(32 * Global.ScaleFactor)
            make.centerX.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(24 * Global.ScaleFactor) //For automatic TV dimension
            make.height.equalToSuperview().multipliedBy(0.35)
            make.bottom.equalToSuperview().offset(-32 * Global.ScaleFactor) //For automatic TV dimension
            make.centerX.equalToSuperview()
        }
        
        
    }
    
}



