//
//  KolodaCardView.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/1/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit
import SnapKit

class KolodaCardView: UIView {
    var nameLabel: UILabel!
    var clothingImageView: UIImageView!
    var labelImageCenteringView: UIView!
    var priceImageCenteringView: UIView!
    var sellerImageView: UIImageView!
    var priceLabel: UILabel!
    var sellerNameLabel: UILabel!
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        
        self.backgroundColor = Global.ThemeColor
        self.clipsToBounds = true
        
        setupSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        clothingImageView.layer.cornerRadius = clothingImageView.frame.height / 10
        sellerImageView.layer.cornerRadius = sellerImageView.frame.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        
        labelImageCenteringView = UIView()
        labelImageCenteringView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelImageCenteringView)
        
        priceImageCenteringView = UIView()
        priceImageCenteringView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(priceImageCenteringView)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 24 * Global.ScaleFactor, weight: .heavy)
        self.addSubview(nameLabel)
        
        clothingImageView = UIImageView()
        clothingImageView.translatesAutoresizingMaskIntoConstraints = false
        clothingImageView.clipsToBounds = true
        clothingImageView.contentMode = .scaleAspectFill
        self.addSubview(clothingImageView)
        
        sellerImageView = UIImageView()
        sellerImageView.translatesAutoresizingMaskIntoConstraints = false
        sellerImageView.clipsToBounds = true
        self.addSubview(sellerImageView)
        
        sellerNameLabel = UILabel()
        sellerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        sellerNameLabel.font = UIFont.systemFont(ofSize: 16 * Global.ScaleFactor, weight: .regular)
        sellerNameLabel.textAlignment = .left
        sellerNameLabel.textColor = .white
        self.addSubview(sellerNameLabel)
        
        priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = UIFont.systemFont(ofSize: 24 * Global.ScaleFactor, weight: .heavy)
        priceLabel.textColor = .white
        priceLabel.textAlignment = .right
        self.addSubview(priceLabel)
        
        setupConstraints()
    }
    
    func configureSubviews(nameLabelText: String, clothingImage: UIImage, sellerImage: UIImage, sellerName: String, price: Int) {
        nameLabel.text = nameLabelText
        clothingImageView.image = clothingImage
        sellerImageView.image = sellerImage
        sellerNameLabel.text = sellerName
        priceLabel.text = "$\(price)"
    }
    
    func setupConstraints() {
        labelImageCenteringView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalTo(clothingImageView.snp.top)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(labelImageCenteringView.snp.centerY)
        }
        
        clothingImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-self.frame.height * 0.03)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(clothingImageView.snp.width).multipliedBy(16.0/9.0)
        }
        
        priceImageCenteringView.snp.makeConstraints { (make) in
            make.top.equalTo(clothingImageView.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        sellerImageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(self.frame.width * 0.05)
            make.top.equalTo(priceImageCenteringView.snp.top)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(sellerImageView.snp.width)
        }
        
        sellerNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(sellerImageView.snp.bottom)
            make.leading.equalTo(sellerImageView.snp.leading)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(sellerImageView.snp.centerY)
            make.centerX.equalToSuperview()
        }
        
    }
    
}


