//
//  SellClothesDetailViewController.swift
//  Hanger
//
//  Created by Sean Corcoran on 8/6/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit
import YPImagePicker

class SellClothesInitalViewController: UIViewController {
    var sellClothesInitalView: SellClothesInitalView!
    let types = Types.allCases.map { $0.rawValue}
    let categories = Categories.allCases.map { $0.rawValue}
    var typeTableViewDataSourceAndDelegate: SellClothesTableViewDSAndDelegate!
    var categoryTableViewDataSourceAndDelegate: SellClothesTableViewDSAndDelegate!
    var imagePicker: YPImagePicker!
    var selectedClothingType = ""
    var selectedClothingCategory = ""
    
    deinit {
        print("inital deinited")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        view.backgroundColor = UIColor(white: 0.6, alpha: 0.6)
        self.typeTableViewDataSourceAndDelegate =  SellClothesTableViewDSAndDelegate(stringArray: types, title: "type")
        typeTableViewDataSourceAndDelegate.cellSelectedDelegate = self
        self.categoryTableViewDataSourceAndDelegate = SellClothesTableViewDSAndDelegate(stringArray: categories, title: "category")
        categoryTableViewDataSourceAndDelegate.cellSelectedDelegate = self
        
        var config = YPImagePickerConfiguration()
        config.screens = [.library, .photo]
        config.shouldSaveNewPicturesToAlbum = false
        config.showsPhotoFilters = false
        imagePicker = YPImagePicker(configuration: config)
        imagePicker.didFinishPicking {  [weak imagePicker, unowned self] items, cancelled in
            if !cancelled {
                for item in items {
                    switch item {
                    case .photo(let photo):
                        self.navigationController?.pushViewController(SellClothesViewController(image: photo.image, imagePicker: self.imagePicker, selectedClothingType: self.selectedClothingType, selectedClothingCategory: self.selectedClothingCategory), animated: true);
                    case .video(_): print("No Video!")
                    }
                }
            }
            imagePicker?.dismiss(animated: true, completion: nil)
        }
        
        sellClothesInitalView = SellClothesInitalView()
        sellClothesInitalView.dismissButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
        sellClothesInitalView.nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        sellClothesInitalView.typeTableView.dataSource = typeTableViewDataSourceAndDelegate
        sellClothesInitalView.typeTableView.delegate = typeTableViewDataSourceAndDelegate
        sellClothesInitalView.categoryTableView.dataSource = categoryTableViewDataSourceAndDelegate
        sellClothesInitalView.categoryTableView.delegate = categoryTableViewDataSourceAndDelegate
        view.addSubview(sellClothesInitalView)
        sellClothesInitalView.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.9)
        }
        
        imagePicker.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: sellClothesInitalView.dismissButton)
        
    }
    
    @objc func dismissButtonPressed() {
        let alertController = UIAlertController(title: "Delete Your Masterpiece?", message: nil, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.view.backgroundColor = .clear //UI Purposes
            self.dismiss(animated: true, completion: nil)
        }
        let nevermindAction = UIAlertAction(title: "Nevermind", style: .cancel, handler: nil)
        alertController.addAction(deleteAction)
        alertController.addAction(nevermindAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func nextButtonPressed() {
        if sellClothesInitalView.typeTableView.indexPathForSelectedRow == nil && sellClothesInitalView.categoryTableView.indexPathForSelectedRow == nil {
            sellClothesInitalView.typeTableView.needsInputBeforeContinuing()
            sellClothesInitalView.categoryTableView.needsInputBeforeContinuing()
            return
        } else if sellClothesInitalView.typeTableView.indexPathForSelectedRow == nil {
            sellClothesInitalView.typeTableView.needsInputBeforeContinuing()
            return
        } else if sellClothesInitalView.categoryTableView.indexPathForSelectedRow == nil {
            sellClothesInitalView.categoryTableView.needsInputBeforeContinuing()
            return
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
}

extension SellClothesInitalViewController: CellSelectedDelegate {
    func cellSelected(indexPath: IndexPath, title: String) {
        switch title {
            case "type": self.selectedClothingType = types[indexPath.row]
            case "category": self.selectedClothingCategory = categories[indexPath.row]
            default: break
        }
    }
}



extension SellClothesInitalViewController {
    func setupNavBar() {
        //Making nav bar transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
}
