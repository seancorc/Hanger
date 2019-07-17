//
//  FilterView.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/14/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class FilterView: UIView {
    var applyButtonContainerView: UIView!
    var applyButton: NiceSpacingButton!
    var tableView: ContentSizedTableView!
    
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupSubviews() {
        
        tableView = ContentSizedTableView()
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        self.addSubview(tableView)
        
        applyButtonContainerView = UIView()
        applyButtonContainerView.backgroundColor = .white
        self.addSubview(applyButtonContainerView)
        
        applyButton = NiceSpacingButton(widthOffset: UIScreen.main.bounds.width * 0.8, heightOffset: 12, hasCornerRadius: true)
        applyButton.setupButton(title: "", backgroundColor: Global.ThemeColor) //Text set in controller as it depends on the number of filters selected
        applyButtonContainerView.addSubview(applyButton)
        
        setupConstraints()
    }
    
    
    func setupConstraints() {
        
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(applyButtonContainerView.snp.bottom)
        }
        
        applyButtonContainerView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        applyButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
    }

    
    
    
    

}
