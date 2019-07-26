//
//  SellClothesView.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/25/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class SellClothesView: UIView {
    
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "exiticon"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: self.frame.width / 8, height: self.frame.height / 8))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    override func didMoveToSuperview() {
        self.addSubview(dismissButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        let padding = 24 * Global.ScaleFactor
        dismissButton.snp.makeConstraints { (make) in
            make.size.equalTo(35 * Global.ScaleFactor)
            make.leading.equalToSuperview().offset(padding)
            make.top.equalToSuperview().offset(padding)
        }
    }
    
    
}
