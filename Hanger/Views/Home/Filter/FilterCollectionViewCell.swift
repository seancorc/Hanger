//
//  FilterCollectionViewCell.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/14/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    lazy var label: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 17 * Global.ScaleFactor)
        label.textAlignment = .center
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.backgroundColor = self.isSelected ? #colorLiteral(red: 1, green: 0.1148675904, blue: 0.2737748325, alpha: 0.6047998716) : .white
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        initalSetup()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.width / 8
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        contentView.addSubview(label)
    }
    
    func initalSetup() {
        self.backgroundView = label
    }
    
    func configureCell(labelText: String) {
        self.label.text = labelText
    }
    
    func setupConstraints() {
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
    }
    
    
}
