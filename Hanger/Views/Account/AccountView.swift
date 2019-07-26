//
//  AccountView.swift
//  Carbon38
//
//  Created by dev on 6/4/19.
//  Copyright © 2019 Carbon38. All rights reserved.
//

import UIKit
import SnapKit

class AccountView: UIView {
    
    lazy var profilePictureButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "sellerimage"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 75 * Global.ScaleFactor
        return button
    }()
    
    lazy var logoutButton: NiceSpacingButton = {
        let button = NiceSpacingButton()
        button.setupButton(title: "Logout", backgroundColor: #colorLiteral(red: 0.9995071292, green: 0.2495709658, blue: 0.2678492069, alpha: 1))
        return button
    }()
    
    lazy var tableView: ContentSizedTableView = {
        let tv = ContentSizedTableView()
        tv.isScrollEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(white: 0.97, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        self.addSubview(tableView)

        
        self.addSubview(profilePictureButton)
        

        self.addSubview(logoutButton)
        
        setupConstraints()
    }
    
    
    func setupConstraints() {
        
        profilePictureButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(50 * Global.ScaleFactor) 
            make.width.height.equalTo(150 * Global.ScaleFactor)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(profilePictureButton.snp.bottom).offset(35 * Global.ScaleFactor)
            make.width.equalTo(self.snp.width)
        }
        
        logoutButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-40 * Global.ScaleFactor)
        }
    }
    
    func updateConstraintsForKeyboard(amount: CGFloat) {
        profilePictureButton.snp.remakeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(50 + amount * Global.ScaleFactor)
            make.width.height.equalTo(150 * Global.ScaleFactor)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        tableView.snp.remakeConstraints { (make) in
            make.width.equalTo(self.snp.width)
            if amount != 0 {make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(amount)}
            else {make.top.equalTo(profilePictureButton.snp.bottom).offset(35 * Global.ScaleFactor)}
        }
        
        
        
    }
        
    
    
}




