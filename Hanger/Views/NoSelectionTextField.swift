//
//  NoSelectionTextField.swift
//  Hanger
//
//  Created by Sean Corcoran on 8/6/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import UIKit

class NoSelectTextField: UITextField {
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
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
        return super.canPerformAction(action, withSender: sender)
    }
    
}
