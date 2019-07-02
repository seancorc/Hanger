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
    var imageView: UIImageView!
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = Global.themeColor
        self.clipsToBounds = true
        
        setupSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.height / 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        
        imageView = UIImageView(image: UIImage(named: "clothingitem"))
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview().multipliedBy(0.8)
        }
    }
    
}


