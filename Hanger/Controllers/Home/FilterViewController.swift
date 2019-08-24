//
//  FilterViewController.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/14/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

//TODO: Put a space to choose more specific filters
class FilterViewController: UIViewController {
    var filterView: FilterView!
    var numberOfSelectedFilters: Int = 0
    var firstCellCVDelegateAndDS: FilterCVDelegateAndDS!
    var seconndCellCVDelegateAndDS: FilterCVDelegateAndDS!
    var thirdCellCVDelegateAndDS: FilterCVDelegateAndDS!
    var fourthCellCVDelegateAndDS: FilterCVDelegateAndDS!
    var tvDelegateAndDS: FilterTVDelegateAndDS!
    var previousSelectionState = [Int:[IndexPath]]()
    var currentSelectionState = [Int:[IndexPath]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        for i in 0...3 {
            currentSelectionState[i] = []
        }
    
        firstCellCVDelegateAndDS = FilterCVDelegateAndDS(stringArray:  Prices.allCases.map { $0.rawValue}, widthMultiplier: 0.22)
        seconndCellCVDelegateAndDS = FilterCVDelegateAndDS(stringArray: Distances.allCases.map { $0.rawValue}, widthMultiplier: 0.2)
        thirdCellCVDelegateAndDS = FilterCVDelegateAndDS(stringArray: Types.allCases.map { $0.rawValue}, widthMultiplier: 0.25)
        fourthCellCVDelegateAndDS = FilterCVDelegateAndDS(stringArray: Categories.allCases.map { $0.rawValue}, widthMultiplier: 0.25)
        tvDelegateAndDS = FilterTVDelegateAndDS(cvDelegateAndDSs: [firstCellCVDelegateAndDS, seconndCellCVDelegateAndDS, thirdCellCVDelegateAndDS, fourthCellCVDelegateAndDS], parentVC: self)
        
        filterView = FilterView()
        filterView.applyButton.addTarget(self, action: #selector(applyButtonPressed), for: .touchUpInside)
        filterView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(filterView)
        filterView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        setupTableviewControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        previousSelectionState = currentSelectionState
    }
    
    private func setupTableviewControl() {
        filterView.tableView.delegate = tvDelegateAndDS
        filterView.tableView.dataSource = tvDelegateAndDS
        filterView.tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: Global.CellID)
    }
    
    @objc func allSwitchToggled(_ sender: Any) {
        guard let controlSwitch = sender as? UISwitch else {return}
        guard let cell = filterView.tableView.cellForRow(at: IndexPath(row: controlSwitch.tag, section: 0)) as? FilterTableViewCell else {return}
        cell.collectionView.alpha = controlSwitch.isOn ? 0.5 : 1
        cell.collectionView.isUserInteractionEnabled = !controlSwitch.isOn
    }
    
    @objc func applyButtonPressed() {
        dismiss(animated: true, completion: nil)
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
        resetButtonPressed()
        for i in 0...3 {
            previousSelectionState[i]?.forEach({ (indexPath) in
                if let cell = self.filterView.tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? FilterTableViewCell {
                    cell.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
                }
            })
        }
    }
    
    @objc func resetButtonPressed() {
        for tableViewRow in 0..<self.filterView.tableView.numberOfRows(inSection: 0) {
            if let cell = filterView.tableView.cellForRow(at: IndexPath(row: tableViewRow, section: 0)) as? FilterTableViewCell {
                cell.allSwitch.setOn(true, animated: true)
                cell.allSwitch.sendActions(for: .valueChanged)
                for ip in cell.collectionView.indexPathsForSelectedItems ?? [] {
                    cell.collectionView.deselectItem(at: ip, animated: false)
                    cell.collectionView.delegate?.collectionView?(cell.collectionView, didDeselectItemAt: ip) //Doesn't call the delegate method for whatever reason so have to manually call it
                }
            }
        }
    }
}
