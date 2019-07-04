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
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        
        setupSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        kolodaView = KolodaView()
        kolodaView.translatesAutoresizingMaskIntoConstraints = false
        kolodaView.backgroundColor = .clear
        self.addSubview(kolodaView)
        
        cityLabel = UILabel()
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = UIFont.systemFont(ofSize: 16 * Global.ScaleFactor, weight: .bold)
        self.addSubview(cityLabel)
        
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
            make.height.equalTo(kolodaView.snp.width).multipliedBy(16.0/9.0)
        }
        
    }

}
