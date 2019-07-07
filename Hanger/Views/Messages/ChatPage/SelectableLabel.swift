//
//  SelectableLabel.swift
//  Carbon38
//
//  Created by dev on 6/18/19.
//  Copyright © 2019 Carbon38. All rights reserved.
//

import UIKit

class SelectableLabel: UILabel {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(showMenu)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
    
    @objc func showMenu(sender: AnyObject?) {
        self.becomeFirstResponder()
        
        let menu = UIMenuController.shared
        
        if !menu.isMenuVisible {
            menu.setTargetRect(self.bounds, in: self)
            menu.setMenuVisible(true, animated: true)
        }
    }
    
    override func copy(_ sender: Any?) {
        let board = UIPasteboard.general
        
        board.string = text
        
        let menu = UIMenuController.shared
        
        menu.setMenuVisible(false, animated: true)
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.copy)
    }
}
