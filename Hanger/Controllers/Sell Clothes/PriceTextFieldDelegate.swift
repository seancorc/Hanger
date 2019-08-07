//
//  PriceTextFieldDelegate.swift
//  Hanger
//
//  Created by Sean Corcoran on 8/6/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import UIKit

class PriceTextFieldDelegate: NSObject, UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text?.isEmpty ?? true {textField.text = "$"}
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "$" {textField.text = ""}
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range != NSRange(location: 0, length: 1)
    }
}

