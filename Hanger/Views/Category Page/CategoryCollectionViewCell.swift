//
//  CategoryCollectionViewCell.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/5/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    var categoryImageView: UIImageView!
    var categoryLabel: UILabel!
    var lineView: UIView!
    var arrowImageView: UIImageView!
    var imageLineCenterView: UIView!
    var arrowLineCenterView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = Global.ThemeColor
        self.contentView.alpha = 0.75
        initalSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initalSetup() {
        
        imageLineCenterView = UIView()
        imageLineCenterView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageLineCenterView)
        
        arrowLineCenterView = UIView()
        arrowLineCenterView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(arrowLineCenterView)
        
        categoryImageView = UIImageView()
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(categoryImageView)
        
        categoryLabel = UILabel()
        categoryLabel.textAlignment = .center
        categoryLabel.textColor = .white
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(categoryLabel)
        
        lineView = UIView()
        lineView.backgroundColor = .white
        lineView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lineView)
        
        arrowImageView = UIImageView()
        arrowImageView.image = #imageLiteral(resourceName: "arrow").withRenderingMode(.alwaysTemplate)
        arrowImageView.tintColor = .white
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(arrowImageView)
        
    }
    
    func configureCell(categoryImage: UIImage, categoryName: String) {
        categoryImageView.image = categoryImage
        categoryLabel.text = categoryName
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        imageLineCenterView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalTo(lineView.snp.leading)
        }
        
        
        categoryImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(imageLineCenterView.snp.centerX)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(categoryImageView.snp.width)
        }
        
        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(categoryImageView.snp.bottom)
            make.centerX.equalTo(categoryImageView.snp.centerX)
        }
        
        
        lineView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(self.frame.width / 4)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.85)
            make.width.equalTo(1)
        }
        
        arrowLineCenterView.snp.makeConstraints { (make) in
            make.leading.equalTo(lineView.snp.trailing)
            make.trailing.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalTo(arrowLineCenterView.snp.centerX)
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalTo(arrowImageView.snp.width)
        }
        
        
    }
    
}
