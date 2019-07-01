//
//  NiceSpacingButton.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/1/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class NiceSpacingButton: UIButton {
    override var intrinsicContentSize: CGSize {
        let origContentSize = super.intrinsicContentSize
        self.clipsToBounds = true
        self.layer.cornerRadius = (origContentSize.height + 12.0) / 2
        return CGSize(width: origContentSize.width + 80.0, height: origContentSize.height + 12.0)
    }
    
    func setupButton(title: String, textColor: UIColor, backgroundColor: UIColor) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: UIControl.State.normal)
        self.titleLabel?.font = UIFont(name: "Helvetica", size: 18)
        self.setTitleColor(textColor, for: UIControl.State.normal)
        self.clipsToBounds = true
        self.backgroundColor = backgroundColor
    }
    
}


