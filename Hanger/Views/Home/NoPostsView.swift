//
//  NoPostsView.swift
//  Hanger
//
//  Created by Sean Corcoran on 8/14/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class NoPostsView: UIView {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6488546133, green: 0.8121441007, blue: 0.8823953271, alpha: 1)
        view.layer.borderColor = #colorLiteral(red: 0.06274509804, green: 0.4509803922, blue: 0.6196078431, alpha: 1).cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica-Bold", size: 22 * Global.ScaleFactor)
        label.textColor = .white
        label.text = "We Can't Find Any Posts In Your Area Right Now."
        return label
    }()
    
    lazy var bottomLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 18 * Global.ScaleFactor)
        label.textColor = .white
        label.text = "Try Changing Your Search Filters or Inviting Friends To Join Hanger!"
        return label
    }()
    
    lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.setTitle("Refresh", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1), for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.03880337998, green: 0.284052521, blue: 0.485560894, alpha: 1), for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        containerView.layer.cornerRadius = self.frame.width / 8
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        containerView.addSubview(topLabel)
        containerView.addSubview(bottomLabel)
        self.addSubview(containerView)
        self.addSubview(refreshButton)
        setupConstraints()
    }
    
    func setupConstraints() {
        let padding = 24 * Global.ScaleFactor
        
        containerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        topLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.bottom.equalTo(containerView.snp.centerY).offset(-padding)
        }
        
        bottomLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.top.equalTo(containerView.snp.centerY).offset(padding)
        }
        
        refreshButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
}
