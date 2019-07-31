//
//  FilterViewController.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/14/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    var filterView: FilterView!
    var numberOfSelectedFilters: Int = 1
    var firstCellTexts = ["$", "$$", "$$$", "$$$$"]
    var secondCellTexts = ["1 Mi", "5 Mi", "10 Mi", "15 Mi", "25 Mi"]
    var thirdCellTexts = ["Male", "Female", "Gender Neutral"]
    var fourthCellTexts = ["Shirts", "Shorts", "Pants", "Shoes", "Hats", "Leggings"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
        filterView = FilterView()
        filterView.applyButton.setTitle("Apply (\(numberOfSelectedFilters))", for: .normal)
        filterView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(filterView)
        filterView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        setupTableviewControl() // Must be called after the creation filterView
        
    }
    
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableviewControl() {
        filterView.tableView.delegate = self
        filterView.tableView.dataSource = self
        filterView.tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: Global.CellID)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Global.CellID, for: indexPath) as! FilterTableViewCell
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.tag = indexPath.row
        cell.collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: Global.CellID)
        switch indexPath.row {
        case 0: cell.configureCell(labelText: "Price Range"); cell.collectionView.allowsMultipleSelection = true
        case 1: cell.configureCell(labelText: "Distance"); cell.collectionView.allowsMultipleSelection = false; cell.collectionView.selectItem(at: IndexPath(row: 2, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        case 2: cell.configureCell(labelText: "Type"); cell.collectionView.allowsMultipleSelection = true
        case 3: cell.configureCell(labelText: "Categories"); cell.collectionView.allowsMultipleSelection = true
        default: print("default")
        }
        return cell
    }
    
}

extension FilterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0: return firstCellTexts.count
        case 1: return secondCellTexts.count
        case 2: return thirdCellTexts.count
        case 3: return fourthCellTexts.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Global.CellID, for: indexPath) as! FilterCollectionViewCell
        var text: String = ""
        switch collectionView.tag {
        case 0: text = firstCellTexts[indexPath.row]
        case 1: text = secondCellTexts[indexPath.row]
        case 2: text = thirdCellTexts[indexPath.row]
        case 3: text = fourthCellTexts[indexPath.row]
        default: text = "ahhhh"
        }
        cell.configureCell(labelText: text)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var text: String = ""
        var widthMultiplier: CGFloat = 0.2
        switch collectionView.tag {
        case 0: text = firstCellTexts[indexPath.row]; widthMultiplier = 0.22
        case 1: text = secondCellTexts[indexPath.row]; widthMultiplier = 0.2
        case 2: text = thirdCellTexts[indexPath.row]; widthMultiplier = 0.3
        case 3: text = fourthCellTexts[indexPath.row]; widthMultiplier = 0.25
        default: text = "ahhhh"
        }
        let NSText = NSString(string: text)
        let size = NSText.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17 * Global.ScaleFactor)])
        return CGSize(width: (size.width + 12) > self.view.frame.width * widthMultiplier ? (size.width + 12) : self.view.frame.width * widthMultiplier, height: size.height * 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.allowsMultipleSelection {
            self.numberOfSelectedFilters += 1
            filterView.applyButton.setTitle("Apply (\(numberOfSelectedFilters))", for: .normal)
            filterView.applyButton.layoutIfNeeded()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView.allowsMultipleSelection {
            self.numberOfSelectedFilters -= 1
            filterView.applyButton.setTitle("Apply (\(numberOfSelectedFilters))", for: .normal)
            filterView.applyButton.layoutIfNeeded()
        }
    }
    
}

extension FilterViewController {
    
    func setupNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        navigationItem.title = "Filters"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetButtonPressed))
    }
    
    @objc func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func resetButtonPressed() {
        for tableViewRow in 0..<self.filterView.tableView.numberOfRows(inSection: 0) {
            if let cell = filterView.tableView.cellForRow(at: IndexPath(row: tableViewRow, section: 0)) as? FilterTableViewCell {
                if tableViewRow != 1 {
                    for ip in cell.collectionView.indexPathsForSelectedItems ?? [] {
                        cell.collectionView.deselectItem(at: ip, animated: false)
                        cell.collectionView.delegate?.collectionView?(cell.collectionView, didDeselectItemAt: ip) //Doesn't call the delegate method for whatever reason so have to manually call it
                    }
                } else {
                    cell.collectionView.selectItem(at: IndexPath(row: 2, section: 0), animated: true, scrollPosition: .centeredHorizontally)
                }
            }
        }
    }
}
