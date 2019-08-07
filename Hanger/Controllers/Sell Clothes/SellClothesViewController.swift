//
//  CreateSaleViewController.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/14/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit
import YPImagePicker

//TODO: Adjust view for keyboard 
class SellClothesViewController: UIViewController {
    var sellClothesView: SellClothesView!
    var imagePicker: YPImagePicker!
    var imageArray = [UIImage]()
    var priceTextFieldDelegate: PriceTextFieldDelegate!
    
    init(image: UIImage) {
        imageArray.append(image)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
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
        sellClothesView.translatesAutoresizingMaskIntoConstraints = false
        sellClothesView.descriptionTextView.delegate = self
        priceTextFieldDelegate = PriceTextFieldDelegate()
        sellClothesView.priceTextField.delegate = priceTextFieldDelegate
        sellClothesView.nameTextField.delegate = self
        sellClothesView.brandTextField.delegate = self
        sellClothesView.keyboardDoneButton.addTarget(self, action: #selector(keyboardDoneButtonPressed), for: .touchUpInside)
        view.addSubview(sellClothesView)
        sellClothesView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        setupCollectionViewControl()
    }
    
    @objc func keyboardDoneButtonPressed() {
        sellClothesView.priceTextField.resignFirstResponder()
    }
    
}


extension SellClothesViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        sellClothesView.descriptionPlaceholer.isHidden = !textView.text.isEmpty
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        sellClothesView.descriptionPlaceholer.isHidden = !textView.text.isEmpty
    }
    
}


extension SellClothesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
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
        return CGSize(width: self.view.frame.width / 6.5, height: self.view.frame.width / 6.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.view.frame.width * 0.01
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

extension SellClothesViewController {
    func setupNavBar() {
        self.navigationItem.title = "Sell Your Clothes"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed))
    }
    
    @objc func cancelButtonPressed() {
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


