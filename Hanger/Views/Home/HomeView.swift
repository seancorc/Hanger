//
//  HomeView.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/1/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit
import Koloda
import SnapKit

class HomeView: UIView {
    var kolodaView: KolodaView!
    var cityLabel: UILabel!
    var pagingControl: UIPageControl!
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        
        setupSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupSubviews() {
        cityLabel = UILabel()
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = UIFont.systemFont(ofSize: 16 * Global.ScaleFactor, weight: .bold)
        self.addSubview(cityLabel)
        
        kolodaView = KolodaView()
        kolodaView.translatesAutoresizingMaskIntoConstraints = false
        kolodaView.backgroundColor = .clear
        self.addSubview(kolodaView)
        
        pagingControl = UIPageControl()
        pagingControl.currentPage = 0
        pagingControl.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        pagingControl.pageIndicatorTintColor = UIColor.darkGray
        pagingControl.currentPageIndicatorTintColor = .white
        self.addSubview(pagingControl)
        
        
        setupConstraints()
    }
    
    func setupConstraints() {
        cityLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.height.equalToSuperview().multipliedBy(0.05)
        }
        
        kolodaView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.9)
        }
        
        
        pagingControl.snp.makeConstraints { (make) in
            make.leading.equalTo(kolodaView.snp.leading).offset(16 * Global.ScaleFactor)
            make.width.equalToSuperview().multipliedBy(0.015) //Need to set width or else width increases with number of pages
            make.centerY.equalToSuperview()
        }
    }
    
}
