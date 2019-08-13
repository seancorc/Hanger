//
//  SellClothesView.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/30/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class SellClothesView: UIView {
    private var placeholderAttributedText: NSAttributedString = NSAttributedString(string: "Brief Description... (optional)", attributes: [NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 16 * Global.ScaleFactor), NSAttributedString.Key.underlineStyle : 1, NSAttributedString.Key.foregroundColor : UIColor.lightGray])
    private let padding = 24 * Global.ScaleFactor
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let insetPadding = 24 * Global.ScaleFactor
        layout.sectionInset = UIEdgeInsets(top: insetPadding, left: insetPadding, bottom: insetPadding, right: insetPadding)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(white: 0.95, alpha: 1)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false
        return cv
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
    
    lazy var keyboardDoneButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 28/255, green: 183/255, blue: 1, alpha: 1)
        button.setTitle("Done", for: .normal)
        return button
    }()
    
    lazy var priceTextField: NoSelectTextField = {
        let textField = NoSelectTextField()
        textField.keyboardType = UIKeyboardType.numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: "Price...", attributes: [NSAttributedString.Key.underlineStyle : 1, NSAttributedString.Key.foregroundColor : UIColor.lightGray,NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 16 * Global.ScaleFactor)])
        textField.font = UIFont(name: "Helvetica", size: 16 * Global.ScaleFactor)
        return textField
    }()
    
    lazy var separatorView4: UIView = {
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
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.isScrollEnabled = false
        textView.layer.borderWidth = 1
        textView.textColor = .black
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Helvetica", size: 16 * Global.ScaleFactor)
        return textView
    }()
    
    lazy var separatorView5: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var postButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Global.ThemeColor
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .onDrag
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        return scrollView
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
        keyboardDoneButton.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height * 0.05)
        postButton.layer.cornerRadius = self.frame.width / 24
    }
    
    override func didMoveToSuperview() {
        stackView.addArrangedSubview(collectionView)
        //stackView.addArrangedSubview(separatorView1)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(separatorView2)
        stackView.addArrangedSubview(brandTextField)
        stackView.addArrangedSubview(separatorView3)
        priceTextField.inputAccessoryView = keyboardDoneButton
        stackView.addArrangedSubview(priceTextField)
        stackView.addArrangedSubview(separatorView4)
        descriptionPlaceholer.attributedText = placeholderAttributedText
        descriptionTextView.addSubview(descriptionPlaceholer)
        stackView.addArrangedSubview(descriptionTextView)
        stackView.addArrangedSubview(separatorView5)
        stackView.addArrangedSubview(postButton)
        
        self.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-padding * 1.5)
            make.leading.trailing.equalToSuperview()
        }
    
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height)
            make.width.equalToSuperview()
        }

        collectionView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.32)
        }

        nameTextField.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalToSuperview().multipliedBy(0.1)
        }

        separatorView2.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(1)
        }

        brandTextField.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalToSuperview().multipliedBy(0.1)
        }

        separatorView3.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(1)
        }
        
        priceTextField.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        separatorView4.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(1)
        }

        descriptionPlaceholer.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(4 * Global.ScaleFactor)
            make.top.equalToSuperview().offset(8 * Global.ScaleFactor)
        }

        descriptionTextView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.87)
            make.height.equalToSuperview().multipliedBy(0.18)
        }
        
        separatorView5.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(1)
        }
        
        postButton.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.06)
        }
        
    }
    
    func updateConstraintsForKeyboard(amount: CGFloat) {
        let bottomOffset = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.size.height + self.scrollView.contentInset.bottom)
        scrollView.setContentOffset(bottomOffset, animated: true)
        stackView.snp.remakeConstraints { (make) in
            make.top.equalToSuperview().offset(amount)
            make.bottom.equalToSuperview().offset(-padding * 1.5 + amount)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height)
            make.width.equalToSuperview()
        }
    }

    
}

