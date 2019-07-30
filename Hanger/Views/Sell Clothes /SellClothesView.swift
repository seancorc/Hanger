//
//  SellClothesView.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/25/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class SellClothesView: UIView {
    private var placeholderAttributedText: NSAttributedString = NSAttributedString(string: "Description...", attributes: [NSAttributedString.Key.font : UIFont(name: "helvetica", size: 16 * Global.ScaleFactor), NSAttributedString.Key.underlineStyle : 1, NSAttributedString.Key.foregroundColor : UIColor.lightGray])
    
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "exiticon"), for: .normal)
        return button
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
        textField.attributedPlaceholder = NSAttributedString(string: "Name...", attributes: [NSAttributedString.Key.underlineStyle : 1, NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 24 * Global.ScaleFactor)])
        textField.font = UIFont.systemFont(ofSize: 24 * Global.ScaleFactor, weight: .heavy)
        return textField
    }()
    
    lazy var separatorView2: UIView = {
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
    
    lazy var separatorView3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
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
        postButton.layer.cornerRadius = postButton.frame.width / 10
    }
    
    override func didMoveToSuperview() {
        self.addSubview(dismissButton)
        
        self.addSubview(collectionView)
        
        self.addSubview(separatorView1)
        
        self.addSubview(nameTextField)
        
        self.addSubview(separatorView2)
        
        self.addSubview(descriptionTextView)
        
        descriptionPlaceholer.attributedText = placeholderAttributedText
        descriptionTextView.addSubview(descriptionPlaceholer)
        
        self.addSubview(separatorView3)
        
        self.addSubview(postButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        let padding = 24 * Global.ScaleFactor
        dismissButton.snp.makeConstraints { (make) in
            make.size.equalTo(35 * Global.ScaleFactor)
            make.leading.equalToSuperview().offset(padding)
            make.top.equalToSuperview().offset(padding)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.95)
            make.height.equalToSuperview().multipliedBy(0.1)
            make.top.equalTo(dismissButton.snp.bottom).offset(padding)
        }
        
        separatorView1.snp.makeConstraints { (make) in
            make.bottom.equalTo(nameTextField.snp.top)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        nameTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalToSuperview().multipliedBy(0.1)
            make.top.equalTo(collectionView.snp.bottom).offset(padding)
        }
        
        separatorView2.snp.makeConstraints { (make) in
            make.top.equalTo(nameTextField.snp.bottom)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        descriptionPlaceholer.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(4 * Global.ScaleFactor)
            make.top.equalToSuperview().offset(8 * Global.ScaleFactor)
        }
        
        descriptionTextView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.87)
            make.height.equalToSuperview().multipliedBy(0.15)
            make.top.equalTo(nameTextField.snp.bottom).offset(padding)
        }
        
        separatorView3.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionTextView.snp.bottom)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        postButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-padding)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        
    }
    
    
}
