//
//  FilterView.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/14/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class FilterView: UIView {
    
    lazy var applyButtonContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var applyButton: NiceSpacingButton = {
        let button = NiceSpacingButton(widthOffset: UIScreen.main.bounds.width * 0.7, heightOffset: 12, hasCornerRadius: true)
        button.setupButton(title: "Apply", backgroundColor: Global.ThemeColor) //Text set in controller as it depends on the number of filters selected
        return button
    }()
    
    lazy var tableView: ContentSizedTableView = {
        let tv = ContentSizedTableView()
        tv.allowsSelection = false
        tv.keyboardDismissMode = .onDrag
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return tv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        self.addSubview(tableView)
        
        self.addSubview(applyButtonContainerView)
        
        applyButtonContainerView.addSubview(applyButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(applyButtonContainerView.snp.top)
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
