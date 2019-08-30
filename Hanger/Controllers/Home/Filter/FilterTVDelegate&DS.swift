//
//  FilterTVDelegate&DS.swift
//  Hanger
//
//  Created by Sean Corcoran on 8/23/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import UIKit

class FilterTVDelegateAndDS: NSObject, UITableViewDelegate, UITableViewDataSource {
    var cvDelegateAndDSs = [FilterCVDelegateAndDS]()
    weak var parentVC: FilterViewController!
    var filterPriceTextFieldDelegate: FilterPriceTextFieldDelegate!
    
    init(cvDelegateAndDSs: [FilterCVDelegateAndDS], parentVC: FilterViewController) {
        super.init()
        self.cvDelegateAndDSs = cvDelegateAndDSs
        self.parentVC = parentVC
        self.filterPriceTextFieldDelegate = FilterPriceTextFieldDelegate()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Price\(Global.CellID)", for: indexPath) as! FilterPriceTableViewCell
            cell.configureCell(labelText: "Price Range", allLabelText: "Any Price")
            cell.allSwitch.tag = indexPath.row
            cell.allSwitch.addTarget(parentVC, action: #selector(FilterViewController.allSwitchToggled), for: .valueChanged)
            cell.keyboardDoneButton.addTarget(parentVC, action: #selector(FilterViewController.keyboardDoneButtonPressed), for: .touchUpInside)
            cell.minPriceTextField.delegate = self.filterPriceTextFieldDelegate
            cell.maxPriceTextField.delegate = self.filterPriceTextFieldDelegate
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Global.CellID, for: indexPath) as! FilterTableViewCell
            cell.collectionView.delegate = cvDelegateAndDSs[indexPath.row - 1]
            cell.collectionView.dataSource = cvDelegateAndDSs[indexPath.row - 1]
            cell.allSwitch.tag = indexPath.row
            cell.allSwitch.addTarget(parentVC, action: #selector(FilterViewController.allSwitchToggled), for: .valueChanged)
            cell.collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: Global.CellID)
            switch indexPath.row {
            case 1: cell.configureCell(labelText: "Distance", allLabelText: "Any Distance"); cell.collectionView.allowsMultipleSelection = false
            case 2: cell.configureCell(labelText: "Types", allLabelText: "Any Type"); cell.collectionView.allowsMultipleSelection = true
            case 3: cell.configureCell(labelText: "Categories", allLabelText: "Any Category"); cell.collectionView.allowsMultipleSelection = true
            default: print("default")
            }
            return cell
        }
    }
}


class FilterPriceTextFieldDelegate: NSObject, UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text?.isEmpty ?? true {textField.text = "$"}
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "$" {textField.text = ""}
        PreviousFilterState.previousMinPriceText = textField.text ?? ""
        PreviousFilterState.previousMaxPriceText = textField.text ?? ""
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range == NSRange(location: 0, length: 1) {return false}
        if range == NSRange(location: 5, length: 0) {return false}
        return true
    }
}
