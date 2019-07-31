//
//  SellClothesView.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/30/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class SellClothesView: UIView {
    private var placeholderAttributedText: NSAttributedString = NSAttributedString(string: "Brief Description...", attributes: [NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 16 * Global.ScaleFactor), NSAttributedString.Key.underlineStyle : 1, NSAttributedString.Key.foregroundColor : UIColor.lightGray])
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
        label.attributedText = NSAttributedString(string: "Sell Your Clothes", attributes: [NSAttributedString.Key.font : UIFont(name: "Helvetica-Bold", size: 18 * Global.ScaleFactor), NSAttributedString.Key.underlineStyle : 1])
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false
        return cv
    }()
    
    lazy var separatorView1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: "Title...", attributes: [NSAttributedString.Key.underlineStyle : 1, NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 20 * Global.ScaleFactor)])
        textField.defaultTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 20 * Global.ScaleFactor)]
        textField.font = UIFont(name: "Helvetica-Bold", size: 20 * Global.ScaleFactor)
        return textField
    }()
    
    lazy var separatorView2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var brandTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: "Brand...", attributes: [NSAttributedString.Key.underlineStyle : 1, NSAttributedString.Key.foregroundColor : UIColor.lightGray,NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 16 * Global.ScaleFactor)])
        textField.font = UIFont(name: "Helvetica", size: 16 * Global.ScaleFactor)
        return textField
    }()
    
    lazy var separatorView3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var descriptionPlaceholer: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Helvetica", size: 16 * Global.ScaleFactor)
        return textView
    }()
    
    lazy var separatorView4: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    
    lazy var typeTableView: UITableView = {
        let tv = UITableView()
        let headerView = UILabel()
        headerView.textAlignment = .center
        headerView.font = UIFont(name: "Helvetica-Bold", size: 16 * Global.ScaleFactor)
        headerView.text = "Type"
        headerView.backgroundColor = .white
        tv.tableHeaderView = headerView
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var separatorView5: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var categoryTableView: UITableView = {
        let tv = UITableView()
        let headerView = UILabel()
        headerView.textAlignment = .center
        headerView.backgroundColor = .white
        headerView.font = UIFont(name: "Helvetica-Bold", size: 16 * Global.ScaleFactor)
        headerView.text = "Category"
        tv.tableHeaderView = headerView
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var separatorView6: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()

    lazy var postButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Global.ThemeColor
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
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: self.frame.width / 10, height: self.frame.height / 10))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        typeTableView.sizeHeaderToFit(padding: padding)
        categoryTableView.sizeHeaderToFit(padding: padding)
        postButton.layer.cornerRadius = postButton.frame.width / 24
        typeTableView.layer.cornerRadius = self.frame.width / 24
        categoryTableView.layer.cornerRadius = self.frame.width / 24
    }
    
    override func didMoveToSuperview() {
        stackView.addArrangedSubview(collectionView)
        stackView.addArrangedSubview(separatorView1)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(separatorView2)
        stackView.addArrangedSubview(brandTextField)
        stackView.addArrangedSubview(separatorView3)
        descriptionPlaceholer.attributedText = placeholderAttributedText
        descriptionTextView.addSubview(descriptionPlaceholer)
        stackView.addArrangedSubview(descriptionTextView)
        stackView.addArrangedSubview(separatorView4)
        stackView.addArrangedSubview(typeTableView)
        stackView.addArrangedSubview(separatorView5)
        stackView.addArrangedSubview(categoryTableView)
        stackView.addArrangedSubview(separatorView6)
        
        self.addSubview(dismissButton)
        
        self.addSubview(sellYourClothesLabel)

        self.addSubview(stackView)
        
        self.addSubview(postButton)
        
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
            make.top.equalTo(dismissButton.snp.bottom).offset(padding)
            make.bottom.equalTo(postButton.snp.top).offset(-padding / 2)
            make.leading.trailing.equalToSuperview()
        }

        collectionView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.95)
            make.height.equalToSuperview().multipliedBy(0.13)
        }

        separatorView1.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(1)
        }

        nameTextField.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalToSuperview().multipliedBy(0.05)
        }

        separatorView2.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(1)
        }

        brandTextField.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalToSuperview().multipliedBy(0.05)
        }

        separatorView3.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(1)
        }

        descriptionPlaceholer.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(4 * Global.ScaleFactor)
            make.top.equalToSuperview().offset(8 * Global.ScaleFactor)
        }

        descriptionTextView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.87)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        separatorView4.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(1)
        }
        
        typeTableView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalToSuperview().multipliedBy(0.22)
        }
        
        separatorView5.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(1)
        }
        
        categoryTableView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalToSuperview().multipliedBy(0.25)
        }
        
        separatorView6.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(1)
        }
        
        postButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-padding)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.05)
        }
        
        
        
    }
    
    
}

