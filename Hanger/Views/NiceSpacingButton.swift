//
//  NiceSpacingButton.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/1/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class NiceSpacingButton: UIButton {
    var widthOffset: CGFloat = 20
    var heightOffset: CGFloat = 12
    var hasCornerRadius: Bool = true
    
    convenience init(widthOffset: CGFloat, heightOffset: CGFloat, hasCornerRadius: Bool) {
        self.init()
        self.widthOffset = widthOffset
        self.heightOffset = heightOffset
        self.hasCornerRadius = hasCornerRadius
    }
    
    override var intrinsicContentSize: CGSize {
        let origContentSize = super.intrinsicContentSize
        if self.hasCornerRadius {
            self.clipsToBounds = true
            self.layer.cornerRadius = (origContentSize.height + self.heightOffset) / 2
        }
        return CGSize(width: origContentSize.width + self.widthOffset, height: origContentSize.height + self.heightOffset)
    }
    
    func setupButton(title: String, textColor: UIColor, backgroundColor: UIColor, fontSize: CGFloat = 18 * Global.ScaleFactor) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: UIControl.State.normal)
        self.titleLabel?.font = UIFont(name: "Helvetica", size: fontSize)
        self.setTitleColor(textColor, for: UIControl.State.normal)
        self.clipsToBounds = true
        self.backgroundColor = backgroundColor
    }
    
}

class NiceSpacingLabel: UILabel {
    var widthOffset: CGFloat = 20
    var heightOffset: CGFloat = 12
    var hasCornerRadius: Bool = true
    
    convenience init(widthOffset: CGFloat, heightOffset: CGFloat, hasCornerRadius: Bool) {
        self.init()
        self.widthOffset = widthOffset
        self.heightOffset = heightOffset
        self.hasCornerRadius = hasCornerRadius
    }
    
    override var intrinsicContentSize: CGSize {
        let origContentSize = super.intrinsicContentSize
        if self.hasCornerRadius {
            self.clipsToBounds = true
            self.layer.cornerRadius = (origContentSize.height + self.heightOffset) / 2
        }
        return CGSize(width: origContentSize.width + self.widthOffset, height: origContentSize.height + self.heightOffset)
    }
    
    
    func setupLabel(text: String, backgroundColor: UIColor, fontSize: CGFloat = 18 * Global.ScaleFactor) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.font = UIFont(name: "Helvetica", size: fontSize)
        self.textColor = .white
        self.clipsToBounds = true
        self.backgroundColor = backgroundColor
    }
}



