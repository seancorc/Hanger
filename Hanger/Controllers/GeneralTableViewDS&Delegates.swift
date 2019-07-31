//
//  TypeTableViewDataSource.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/30/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import UIKit

fileprivate let fade = CABasicAnimation(keyPath: "backgroundColor")
fileprivate func fadeAnimation(cell: UITableViewCell) {
    fade.fromValue = cell.backgroundColor?.cgColor
    fade.toValue = UIColor.gray.cgColor
    fade.duration = 0.15
    fade.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    fade.autoreverses = true
    fade.isRemovedOnCompletion = true
    cell.layer.add(fade, forKey: "fade")
}

class GeneralTableViewDataSourceAndDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    var stringArray = [String]()
    
    init(stringArray: [String]) {
        super.init()
        self.stringArray = stringArray
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stringArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: Global.CellID)
        cell.selectionStyle = .none
        cell.backgroundColor = tableView.backgroundColor
        cell.textLabel?.text = stringArray[indexPath.row]
        cell.textLabel?.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {return}
        fadeAnimation(cell: cell)
        cell.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {return}
        cell.accessoryType = .none
    }
}
