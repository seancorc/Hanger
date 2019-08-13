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
    override class var requiresConstraintBasedLayout: Bool {return true}
    
    lazy var nameandBrandLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isPagingEnabled = true
        cv.clipsToBounds = true
        return cv
    }()
    
    lazy var labelImageCenteringView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var priceImageCenteringView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var sellerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "defaultprofilepicture")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var sellerNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16 * Global.ScaleFactor, weight: .regular)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24 * Global.ScaleFactor, weight: .heavy)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Global.ThemeColor
        self.clipsToBounds = true
        }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.layer.cornerRadius = collectionView.frame.height / 35
        sellerImageView.layer.cornerRadius = sellerImageView.frame.width / 2
        self.layer.cornerRadius = self.frame.height / 50
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        self.addSubview(labelImageCenteringView)

        self.addSubview(priceImageCenteringView)
        
        self.addSubview(nameandBrandLabel)
        
        self.addSubview(collectionView)
        
        self.addSubview(sellerImageView)
        
        self.addSubview(sellerNameLabel)
        
        self.addSubview(priceLabel)
        
        setupConstraints()
    }
    
    func configureSubviews(name: String, brand: String, sellerProfilePicURL: String?, sellerName: String, price: String) {
        let mainString = NSMutableAttributedString(string: "\(name)\n", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24 * Global.ScaleFactor, weight: .heavy)])
        let brandString = NSMutableAttributedString(string: brand, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18 * Global.ScaleFactor, weight: .medium)])
        mainString.append(brandString)
        nameandBrandLabel.attributedText = mainString
        if let url = sellerProfilePicURL {
            let success = sellerImageView.loadFromURL(photoUrl: url)
        }
        sellerNameLabel.text = sellerName
        priceLabel.text = "$\(price)"
    }
    
    func setupConstraints() {
        let collectionViewCenterYOffset = -24 * Global.ScaleFactor
        let sellerImageViewLeadingPadding = 24 * Global.ScaleFactor
        let sellerImageViewTopPadding = 12 * Global.ScaleFactor
        
        labelImageCenteringView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalTo(collectionView.snp.top)
        }
        
        nameandBrandLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(labelImageCenteringView.snp.centerY)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(collectionViewCenterYOffset)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalToSuperview().multipliedBy(0.75)
        }
        
        priceImageCenteringView.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        sellerImageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(sellerImageViewLeadingPadding)
            make.top.equalTo(priceImageCenteringView.snp.top).offset(sellerImageViewTopPadding)
            make.height.equalToSuperview().multipliedBy(0.1)
            make.width.equalTo(sellerImageView.snp.height)
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


