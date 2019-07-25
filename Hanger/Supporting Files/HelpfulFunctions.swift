//
//  HelpfulFunctions.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/3/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import UIKit
import MapKit.MKUserLocation


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
    
     static func signInAnimation() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let tabBarController = TabBarController(userManager: .currentUser(), networkManager: .shared())
        let snapshot: UIView? = appDelegate?.window?.snapshotView(afterScreenUpdates: true)
        let loginViewController = UIApplication.shared.keyWindow?.rootViewController
        UIApplication.shared.keyWindow?.rootViewController = tabBarController
        if let snapshot = snapshot {
            tabBarController.view.addSubview(snapshot)
            UIView.animate(withDuration: 0.5, animations: {
                snapshot.layer.opacity = 0
                snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
            }, completion: { (completed) in
                snapshot.removeFromSuperview()
                loginViewController?.removeFromParent()
            })
        }
    }
    
    static func signOutAnimation() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let loginController = LoginViewController(userManager: .currentUser(), networkManager: .shared(), userDefaults: .standard)
        let snapshot: UIView? = appDelegate?.window?.snapshotView(afterScreenUpdates: true)
        let loginViewController = UIApplication.shared.keyWindow?.rootViewController
        UIApplication.shared.keyWindow?.rootViewController = loginController
        if let snapshot = snapshot {
            loginController.view.addSubview(snapshot)
            UIView.animate(withDuration: 0.5, animations: {
                snapshot.layer.opacity = 0
                snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
            }, completion: { (completed) in
                snapshot.removeFromSuperview()
                loginViewController?.removeFromParent()
            })
        }
    }
    
    static func createAlert(for alert: String, okHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController  {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: okHandler)
        alertController.addAction(alertAction)
        return alertController
    }
    
    
}
