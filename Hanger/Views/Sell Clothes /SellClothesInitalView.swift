//
//  SellClothesDetailView.swift
//  Hanger
//
//  Created by Sean Corcoran on 8/6/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import UIKit

class SellClothesInitalView: UIView {
    private let padding = 24 * Global.ScaleFactor
    
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "exiticon"), for: .normal)
        return button
    }()
    
    lazy var sellYourClothesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "First, What Are You Selling?", attributes: [NSAttributedString.Key.font : UIFont(name: "Helvetica-Bold", size: 18 * Global.ScaleFactor), NSAttributedString.Key.underlineStyle : 1])
        return label
    }()
    
    
    lazy var typeTableView: UITableView = {
        let tv = UITableView()
        let headerView = UILabel()
        headerView.textAlignment = .center
        headerView.font = UIFont(name: "Helvetica-Bold", size: 20 * Global.ScaleFactor)
        headerView.text = "Type"
        tv.tableHeaderView = headerView
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var separatorView1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var categoryTableView: UITableView = {
        let tv = UITableView()
        let headerView = UILabel()
        headerView.textAlignment = .center
        headerView.font = UIFont(name: "Helvetica-Bold", size: 20 * Global.ScaleFactor)
        headerView.text = "Category"
        tv.tableHeaderView = headerView
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var separatorView2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Global.ThemeColor
        return button
    }()
    
    lazy var nextButtonArrow: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "rightskinnyarrow").withRenderingMode(.alwaysTemplate))
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: self.frame.width / 10, height: self.frame.height / 10))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        typeTableView.sizeHeaderToFit(padding: padding)
        categoryTableView.sizeHeaderToFit(padding: padding)
        typeTableView.layer.cornerRadius = self.frame.width / 24
        categoryTableView.layer.cornerRadius = self.frame.width / 24
        nextButton.layer.cornerRadius = nextButtonArrow.frame.width / 16
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        stackView.addArrangedSubview(typeTableView)
        stackView.addArrangedSubview(separatorView1)
        stackView.addArrangedSubview(categoryTableView)
        stackView.addArrangedSubview(separatorView2)
        
        self.addSubview(dismissButton)
        
        self.addSubview(sellYourClothesLabel)
        
        self.addSubview(stackView)
        
        nextButton.addSubview(nextButtonArrow)
        self.addSubview(nextButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        sellYourClothesLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(dismissButton.snp.centerY)
            make.centerX.equalToSuperview()
        }
        
        dismissButton.snp.makeConstraints { (make) in
            make.size.equalTo(35 * Global.ScaleFactor)
            make.leading.equalToSuperview().offset(padding)
            make.top.equalToSuperview().offset(padding)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(dismissButton.snp.bottom).offset(padding * 1.5)
            make.bottom.equalTo(nextButton.snp.top).offset(-padding / 2)
            make.leading.trailing.equalToSuperview()
        }
        
        typeTableView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalToSuperview().multipliedBy(0.46)
        }
        
        separatorView1.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(1)
        }
        
        categoryTableView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalToSuperview().multipliedBy(0.45)
        }
        
        separatorView2.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(1)
        }
        
        nextButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-padding)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.06)
        }
        
        nextButtonArrow.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-padding)
            make.width.equalToSuperview().multipliedBy(0.1)
            make.height.equalTo(nextButtonArrow.snp.width)
        }
        
        
    }
    
    
}
