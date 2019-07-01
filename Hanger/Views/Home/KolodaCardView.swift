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
        
        self.backgroundColor = #colorLiteral(red: 0.9911627173, green: 0.6678413749, blue: 0.3004458249, alpha: 1)
        self.clipsToBounds = true
        self.layer.cornerRadius = 15
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        
        imageView = UIImageView(image: UIImage(named: "clothingitem"))
        self.addSubview(imageView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
}


