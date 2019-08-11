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
    
    lazy var dimView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        return view
    }()
    
    lazy var editLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Edit"
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 18 * Global.ScaleFactor)
        return label
    }()
    
    lazy var profilePictureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "defaultprofilepicture")!, for: .normal)
        button.backgroundColor = .gray
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
        profilePictureButton.addSubview(dimView)
        dimView.addSubview(editLabel)
        

        self.addSubview(logoutButton)
        
        setupConstraints()
    }
    
    
    func setupConstraints() {
        
        profilePictureButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(50 * Global.ScaleFactor) 
            make.width.height.equalTo(150 * Global.ScaleFactor)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        dimView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.25)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        editLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
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
        tableView.snp.remakeConstraints { (make) in
            make.width.equalTo(self.snp.width)
            if amount != 0 {make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(amount)}
            else {make.top.equalTo(profilePictureButton.snp.bottom).offset(35 * Global.ScaleFactor)}
        }
        
    }
        
    
    
}




