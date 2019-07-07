//
//  DateMessageHeaderView.swift
//  Carbon38
//
//  Created by dev on 6/7/19.
//  Copyright © 2019 Carbon38. All rights reserved.
//

import UIKit

class DateMessageHeaderView: UILabel {
    override var intrinsicContentSize: CGSize {
        let origContentSize = super.intrinsicContentSize
        self.clipsToBounds = true
        self.layer.cornerRadius = (origContentSize.height + 12.0) / 2
        return CGSize(width: origContentSize.width + 20.0, height: origContentSize.height + 12.0)
    }
    
    func setupLabel(date: String) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = date
        self.textColor = .black
        self.textAlignment = .center
        self.backgroundColor = Global.ThemeColor
        self.font = UIFont(name: "Helvetica", size: 14)
    }

}
