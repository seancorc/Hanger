//
//  SellClothesCollectionViewCell.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/30/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class SellClothesCollectionViewCell: UICollectionViewCell {
    var haveDashedBorder: Bool = true
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var imageBorder: CAShapeLayer = {
        let border = CAShapeLayer()
        border.strokeColor = UIColor.lightGray.cgColor
        border.lineDashPattern = [2, 2]
        border.frame = self.bounds
        border.fillColor = nil
        border.path = UIBezierPath(rect: self.bounds).cgPath
        return border
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        self.backgroundView = imageView
        
        imageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(self.snp.size)
        }
        
        self.layer.addSublayer(imageBorder)
            
    }
    
    
}
