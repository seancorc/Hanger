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
    
    func setupButton(title: String, backgroundColor: UIColor, fontSize: CGFloat = 18 * Global.ScaleFactor) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: UIControl.State.normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        self.setTitleColor(.white, for: UIControl.State.normal)
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
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textColor = .white
        self.clipsToBounds = true
        self.backgroundColor = backgroundColor
    }
}

class NiceSpacingTextField: UITextField {
    var textInset: CGFloat = 24 * Global.ScaleFactor
    var selectable: Bool = true
    
    convenience init(textInset: CGFloat = 24 * Global.ScaleFactor, selectable: Bool = true) {
        self.init()
        self.textInset = textInset
        self.selectable = selectable
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        return CGRect(x: bounds.minX + textInset, y: bounds.minY, width: bounds.width, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds)
        return CGRect(x: bounds.minX + textInset, y: bounds.minY, width: bounds.width, height: bounds.height)
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if !selectable {
            if action == #selector(paste(_:)) ||
                action == #selector(cut(_:)) ||
                action == #selector(copy(_:)) ||
                action == #selector(select(_:)) ||
                action == #selector(selectAll(_:)) ||
                action == #selector(delete(_:)) ||
                action == #selector(makeTextWritingDirectionLeftToRight(_:)) ||
                action == #selector(makeTextWritingDirectionRightToLeft(_:)) ||
                action == #selector(toggleBoldface(_:)) ||
                action == #selector(toggleItalics(_:)) ||
                action == #selector(toggleUnderline(_:)) {
                return false
            }
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
}



