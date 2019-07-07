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
    var profilePictureButton: UIButton!
    var backButton: UIButton!
    var logoutButton: NiceSpacingButton!
    var tableView: ContentSizedTableView!
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(white: 0.95, alpha: 1)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupSubviews() {
        
        tableView = ContentSizedTableView()
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        self.addSubview(tableView)
        
        backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(named: "leftthickarrow"), for: .normal)
        self.addSubview(backButton)
        
        profilePictureButton = UIButton()
        profilePictureButton.setBackgroundImage(UIImage(named: "sellerimage"), for: .normal)
        profilePictureButton.translatesAutoresizingMaskIntoConstraints = false
        profilePictureButton.clipsToBounds = true
        profilePictureButton.layer.cornerRadius = 75 * Global.ScaleFactor
        self.addSubview(profilePictureButton)
        
        logoutButton = NiceSpacingButton()
        logoutButton.setupButton(title: "Logout", textColor: .white, backgroundColor: #colorLiteral(red: 0.9995071292, green: 0.2495709658, blue: 0.2678492069, alpha: 1))
        self.addSubview(logoutButton)
        
        setupConstraints()
    }
    
    
    func setupConstraints() {
        backButton.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading).offset(20 * Global.ScaleFactor)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20 * Global.ScaleFactor)
            make.width.height.equalTo(Global.BackButtonSize)
        }
        
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




