//
//  SellClothesView.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/30/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class SellClothesView: UIView {
    private var placeholderAttributedText: NSMutableAttributedString = NSMutableAttributedString(string: "Brief Description...", attributes: [NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 16 * Global.ScaleFactor) as Any, NSAttributedString.Key.underlineStyle : 1, NSAttributedString.Key.foregroundColor : UIColor.lightGray])
    private var placeholderAttributedText2: NSMutableAttributedString = NSMutableAttributedString(string: " (optional)", attributes: [NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 16 * Global.ScaleFactor) as Any, NSAttributedString.Key.foregroundColor : UIColor.lightGray])
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
    
    lazy var nameTextField: NiceSpacingTextField = {
        let textField = NiceSpacingTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: "Title...", attributes: [NSAttributedString.Key.underlineStyle : 1, NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 20 * Global.ScaleFactor) as Any])
        textField.defaultTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 20 * Global.ScaleFactor) as Any]
        textField.font = UIFont(name: "Helvetica-Bold", size: 20 * Global.ScaleFactor)
        return textField
    }()
    
    lazy var separatorView2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var brandTextField: NiceSpacingTextField = {
        let textField = NiceSpacingTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: "Brand...", attributes: [NSAttributedString.Key.underlineStyle : 1, NSAttributedString.Key.foregroundColor : UIColor.lightGray,NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 16 * Global.ScaleFactor) as Any])
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
    
    lazy var priceTextField: NiceSpacingTextField = {
        let textField = NiceSpacingTextField(selectable: false)
        textField.keyboardType = UIKeyboardType.numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: "Price...", attributes: [NSAttributedString.Key.underlineStyle : 1, NSAttributedString.Key.foregroundColor : UIColor.lightGray,NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 16 * Global.ScaleFactor) as Any])
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
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.isScrollEnabled = false
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
    
    lazy var locationButton: LocButton = {
        let button = LocButton()
        return button
    }()
    
    lazy var separatorView6: UIView = {
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
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(brandTextField)
        priceTextField.inputAccessoryView = keyboardDoneButton
        stackView.addArrangedSubview(priceTextField)
        placeholderAttributedText.append(placeholderAttributedText2)
        descriptionPlaceholer.attributedText = placeholderAttributedText
        descriptionTextView.addSubview(descriptionPlaceholer)
        stackView.addArrangedSubview(descriptionTextView)
        stackView.addArrangedSubview(locationButton)
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
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
     
        brandTextField.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        
        priceTextField.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        

        descriptionPlaceholer.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(4 * Global.ScaleFactor)
            make.top.equalToSuperview().offset(8 * Global.ScaleFactor)
        }
        
        descriptionTextView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.87)
            make.height.equalToSuperview().multipliedBy(0.18)
        }
        
        
        locationButton.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.15)
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

class LocButton: UIButton {
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Location"
        label.textColor = .lightGray
        label.font = UIFont(name: "Helvetica", size: 16 * Global.ScaleFactor)
        return label
    }()
    
    lazy var mapIcon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "locationicon")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .lightGray
        return iv
    }()
    
    
    lazy var arrow: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "rightskinnyarrow")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .lightGray
        return iv
    }()

    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.addSubview(label)
        self.addSubview(mapIcon)
        self.addSubview(arrow)
        let padding = 8 * Global.ScaleFactor
        self.label.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        })
        self.mapIcon.snp.makeConstraints { (make) in
            make.leading.equalTo(label.snp.trailing).offset(padding)
            make.centerY.equalToSuperview()
            make.width.equalTo(label.snp.height).multipliedBy(1.2)
        }
        self.arrow.snp.makeConstraints({ (make) in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(35 * Global.ScaleFactor)
        })
    }
    
}

