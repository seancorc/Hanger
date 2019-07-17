//
//  CardCollectionViewCell.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/16/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        initalSetup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initalSetup() {
        imageView = UIImageView()
        imageView.backgroundColor = UIColor(white: 0.98, alpha: 1)
        imageView.contentMode = .scaleToFill
        contentView.addSubview(imageView)
    }
    
    func configureCell(image: UIImage) {
        self.imageView.image = image
        setupConstraints()
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    
}

