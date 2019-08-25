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
    
    init(cvDelegateAndDSs: [FilterCVDelegateAndDS], parentVC: FilterViewController) {
        super.init()
        self.cvDelegateAndDSs = cvDelegateAndDSs
        self.parentVC = parentVC
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Global.CellID, for: indexPath) as! FilterTableViewCell
        cell.collectionView.delegate = cvDelegateAndDSs[indexPath.row]
        cell.collectionView.dataSource = cvDelegateAndDSs[indexPath.row]
        cell.allSwitch.tag = indexPath.row
        cell.allSwitch.addTarget(parentVC, action: #selector(FilterViewController.allSwitchToggled), for: .valueChanged)
        cell.collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: Global.CellID)
        switch indexPath.row {
        case 0: cell.configureCell(labelText: "Price Range", allLabelText: "Any Price"); cell.collectionView.allowsMultipleSelection = true
        case 1: cell.configureCell(labelText: "Distance", allLabelText: "Any Distance"); cell.collectionView.allowsMultipleSelection = false
        case 2: cell.configureCell(labelText: "Type", allLabelText: "Any Type"); cell.collectionView.allowsMultipleSelection = true
        case 3: cell.configureCell(labelText: "Categories", allLabelText: "Any Category"); cell.collectionView.allowsMultipleSelection = true
        default: print("default")
        }
        return cell
    }
}
