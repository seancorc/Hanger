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
fileprivate func selectedAnimation(cell: UITableViewCell) {
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75 * Global.ScaleFactor
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: Global.CellID)
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(white: 0.98, alpha: 1)
        cell.textLabel?.text = stringArray[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 14 * Global.ScaleFactor)
        cell.textLabel?.backgroundColor = .clear
        if tableView.indexPathForSelectedRow == indexPath {cell.accessoryType = .checkmark}
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {return}
        selectedAnimation(cell: cell)
        tableView.inputGiven()
        cell.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {return}
        cell.accessoryType = .none
    }
}
