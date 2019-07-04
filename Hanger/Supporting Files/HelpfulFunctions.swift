//
//  HelpfulFunctions.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/3/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import UIKit


public class HelpfulFunctions {
    
    /**
     Returns specified constraint object of view (nil if not found)
     - parameter attribute: Which constraint you want from the view, EX: NSLayouConstraint.Attribute.height
     - parameter view: The view whos specified constraint attribute this function returns
     */
    public static func getViewConstraint(attribute: NSLayoutConstraint.Attribute, view: UIView) -> NSLayoutConstraint? {
        var desiredConstraint: NSLayoutConstraint? = nil
        view.constraints.forEach { (constraint) in
            if constraint.firstAttribute == attribute {
                desiredConstraint = constraint
            }
        }
        return desiredConstraint
    }
    
    public static func getBottomMostTableViewIndexPath(tableView: UITableView) -> IndexPath? {
        let bottomSection = tableView.numberOfSections - 1
        if bottomSection >= 0 {
            let bottomRow = tableView.numberOfRows(inSection: bottomSection) - 1
            if bottomRow >= 0 {
                return IndexPath(row:  bottomRow, section: bottomSection)
            }
        }
        return nil
    }
    
}
