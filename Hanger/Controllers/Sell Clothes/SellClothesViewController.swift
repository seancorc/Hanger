//
//  CreateSaleViewController.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/14/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit
import YPImagePicker

class SellClothesViewController: UIViewController {
    var sellClothesView: SellClothesView!
    var imagePicker: YPImagePicker!
    let typeTableViewDataSourceAndDelegate = GeneralTableViewDataSourceAndDelegate(stringArray: ["Male", "Female", "Gender Neutral"])
    let categoryTableViewDataSourceAndDelegate = GeneralTableViewDataSourceAndDelegate(stringArray: ["Shirts", "Shorts", "Pants", "Shoes", "Hats", "Leggings"])
    var imageArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.6, alpha: 0.6)
        
        var config = YPImagePickerConfiguration()
        config.screens = [.library, .photo]
        config.shouldSaveNewPicturesToAlbum = false
        config.showsPhotoFilters = false
        imagePicker = YPImagePicker(configuration: config)
        imagePicker.didFinishPicking {  [weak imagePicker] items, cancelled in
            if !cancelled {
                for item in items {
                    switch item {
                    case .photo(let photo): self.imageArray.append(photo.image); self.sellClothesView.collectionView.reloadData()
                    case .video(_): print("No Video!")
                    }
                }
            }
            imagePicker?.dismiss(animated: true, completion: nil)
        }
        
        sellClothesView = SellClothesView()
        sellClothesView.typeTableView.dataSource = typeTableViewDataSourceAndDelegate
        sellClothesView.typeTableView.delegate = typeTableViewDataSourceAndDelegate
        sellClothesView.categoryTableView.dataSource = categoryTableViewDataSourceAndDelegate
        sellClothesView.categoryTableView.delegate = categoryTableViewDataSourceAndDelegate
        sellClothesView.dismissButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
        sellClothesView.translatesAutoresizingMaskIntoConstraints = false
        sellClothesView.descriptionTextView.delegate = self
        view.addSubview(sellClothesView)
        sellClothesView.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.9)
        }
        
        setupCollectionViewControl()
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
    
}

extension SellClothesViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        sellClothesView.descriptionPlaceholer.isHidden = !textView.text.isEmpty
    }
}


extension SellClothesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setupCollectionViewControl() {
        sellClothesView.collectionView.delegate = self
        sellClothesView.collectionView.dataSource = self
        sellClothesView.collectionView.register(SellClothesCollectionViewCell.self, forCellWithReuseIdentifier: Global.CellID)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 6, height: self.view.frame.height * 0.08)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Global.CellID, for: indexPath) as! SellClothesCollectionViewCell
        var image: UIImage? = nil
        if indexPath.row < imageArray.count {
            image = imageArray[indexPath.row]
        } else if indexPath.row == imageArray.count {
            image = UIImage(named: "cameraicon")
            cell.imageView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        }
        cell.imageView.image = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == imageArray.count {
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
}
