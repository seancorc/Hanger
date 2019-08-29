//
//  CardCollectionViewCell.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/16/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    static let defaultImage = UIImage(named: "exiticon")
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = CardCollectionViewCell.defaultImage
        imageView.backgroundColor = UIColor(white: 0.98, alpha: 1)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMoveToSuperview() {
        contentView.addSubview(imageView)
        setupConstraints()
    }
    
    func configureCell(imageURL: String) {
        if imageView.image == CardCollectionViewCell.defaultImage {
            self.imageView.loadFromURL(photoUrl: imageURL)
        }
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    
}

