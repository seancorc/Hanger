//
//  FilterViewController.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/14/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

protocol FilterSelectedDelegate: class {
    func filtersApplied(radius: Int?, type: String?, category: String?, minPrice: Int?, maxPrice: Int?)
}

//TODO: When cancel is pressed revert to previous state of filters
//Put a space to choose more specific filters
class FilterViewController: UIViewController {
    var filterView: FilterView!
    var numberOfSelectedFilters: Int = 0
    var firstCellCVDelegateAndDS: FilterCVDelegateAndDS!
    var secondCellCVDelegateAndDS: FilterCVDelegateAndDS!
    var thirdCellCVDelegateAndDS: FilterCVDelegateAndDS!
    var tvDelegateAndDS: FilterTVDelegateAndDS!
    weak var filterSelectedDelegate: FilterSelectedDelegate!
    var currentSelectionState = [Int: [IndexPath]]()
    var previousSelectionState = [Int: [IndexPath]]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    
        firstCellCVDelegateAndDS = FilterCVDelegateAndDS(stringArray: Distances.allCases.map { "\($0.rawValue) Mi"}, widthMultiplier: 0.2)
        secondCellCVDelegateAndDS = FilterCVDelegateAndDS(stringArray: Types.allCases.map { $0.rawValue}, widthMultiplier: 0.25)
        thirdCellCVDelegateAndDS = FilterCVDelegateAndDS(stringArray: Categories.allCases.map { $0.rawValue}, widthMultiplier: 0.25)
        tvDelegateAndDS = FilterTVDelegateAndDS(cvDelegateAndDSs: [firstCellCVDelegateAndDS, secondCellCVDelegateAndDS, thirdCellCVDelegateAndDS], parentVC: self)
        
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
        filterView.tableView.register(FilterPriceTableViewCell.self, forCellReuseIdentifier: "Price\(Global.CellID)")
    }
    
    @objc func allSwitchToggled(_ sender: Any) {
        guard let controlSwitch = sender as? UISwitch else {return}
        if let cell = filterView.tableView.cellForRow(at: IndexPath(row: controlSwitch.tag, section: 0)) as? FilterTableViewCell {
            cell.collectionView.alpha = controlSwitch.isOn ? 0.5 : 1
            cell.collectionView.isUserInteractionEnabled = !controlSwitch.isOn
        }
        if let cell = filterView.tableView.cellForRow(at: IndexPath(row: controlSwitch.tag, section: 0)) as? FilterPriceTableViewCell {
            let alpha: CGFloat = controlSwitch.isOn ? 0.4 : 1
            cell.minPriceTextField.alpha = alpha
            cell.maxPriceTextField.alpha = alpha
            cell.dash.alpha = alpha
            cell.minPriceTextField.isUserInteractionEnabled = !controlSwitch.isOn
            cell.maxPriceTextField.isUserInteractionEnabled = !controlSwitch.isOn
        }
    }
    
    @objc func keyboardDoneButtonPressed() {
        filterView.endEditing(true)
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
            if let cell = filterView.tableView.cellForRow(at: IndexPath(row: tableViewRow, section: 0)) as? FilterPriceTableViewCell {
                cell.allSwitch.setOn(true, animated: true)
                cell.allSwitch.sendActions(for: .valueChanged)
                cell.maxPriceTextField.text = ""
                cell.minPriceTextField.text = ""
            }
        }
    }
}
