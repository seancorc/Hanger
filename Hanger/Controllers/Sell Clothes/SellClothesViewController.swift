//
//  CreateSaleViewController.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/14/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit
import YPImagePicker

fileprivate let fakeS3URLString = "https://picsum.photos/200"

class SellClothesViewController: UIViewController {
    var sellClothesView: SellClothesView!
    var imagePicker: YPImagePicker!
    var networkManager: NetworkManager!
    var imageArray = [UIImage]()
    var imageURLs = [String]()
    var selectedClothingType: String!
    var selectedClothingCategory: String!
    var priceTextFieldDelegate: PriceTextFieldDelegate!
    
    deinit {
        print("regular deinited")
    }
    
    init(image: UIImage, imagePicker: YPImagePicker, networkManager: NetworkManager = .shared(), selectedClothingType: String, selectedClothingCategory: String) {
        imageArray.append(image)
        imageURLs.append(fakeS3URLString)
        self.imagePicker = imagePicker
        self.selectedClothingType = selectedClothingType
        self.selectedClothingCategory = selectedClothingCategory
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        view.backgroundColor = UIColor(white: 0.6, alpha: 0.6)
        

        imagePicker.didFinishPicking {  [weak imagePicker, unowned self] items, cancelled in
            if !cancelled {
                for item in items {
                    switch item {
                    case .photo(let photo):
                        //Beep boop upload to S3
                        self.imageURLs.append(fakeS3URLString)
                        self.imageArray.append(photo.image)
                        self.sellClothesView.collectionView.reloadData()
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
        sellClothesView.postButton.addTarget(self, action: #selector(postButtonPressed), for: .touchUpInside)
        view.addSubview(sellClothesView)
        sellClothesView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        //Handle keyboard showing - needs to be refined along with constraints for tableview
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setupCollectionViewControl()
    }
    
    @objc func keyboardDoneButtonPressed() {
        sellClothesView.priceTextField.resignFirstResponder()
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            
            let isKeyboardOpen = notification.name == UIResponder.keyboardWillShowNotification
            
            if sellClothesView.priceTextField.isFirstResponder || sellClothesView.descriptionTextView.isFirstResponder {
                sellClothesView.updateConstraintsForKeyboard(amount: isKeyboardOpen ?  -keyboardFrame.height : 0)
            }
            
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
}


extension SellClothesViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        sellClothesView.descriptionPlaceholer.isHidden = !textView.text.isEmpty
        if textView.layer.borderColor == UIColor.red.cgColor {
            textView.inputGiven(borderColor: UIColor.lightGray.cgColor, borderWidth: 1)
        }
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.layer.borderWidth == 1 {
            textField.inputGiven()
        }
         return true
    }
    
}


extension SellClothesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setupCollectionViewControl() {
        sellClothesView.collectionView.delegate = self
        sellClothesView.collectionView.dataSource = self
        sellClothesView.collectionView.register(SellClothesCollectionViewCell.self, forCellWithReuseIdentifier: Global.CellID)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 5, height: self.view.frame.width / 5)
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
            cell.imageView.backgroundColor = .white
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
        
        let dismissButton: UIButton = {
            let button = UIButton()
            button.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setBackgroundImage(UIImage(named: "exiticon"), for: .normal)
            button.snp.makeConstraints({ (make) in
                make.size.equalTo(35 * Global.ScaleFactor)
            })
            return button
        }()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: dismissButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(postButtonPressed))
        
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
    
    @objc func postButtonPressed() {
        var postable = true
        for view in sellClothesView.stackView.arrangedSubviews {
            if let tf = view as? UITextField {
                if !tf.hasText {tf.needsInputBeforeContinuing(); postable = false}
            }
        }
        if !postable {return}
        let possibleDescriptionText = sellClothesView.descriptionTextView.hasText ? sellClothesView.descriptionTextView.text : nil
        let createPostTask = CreatePostTask(clothingType: self.selectedClothingType, category: self.selectedClothingCategory, name: sellClothesView.nameTextField.text ?? "", brand: sellClothesView.brandTextField.text ?? "",price: sellClothesView.priceTextField.text ?? "", description: possibleDescriptionText, imageURLs: self.imageURLs)
        createPostTask.execute(in: self.networkManager).then { (clothingPost) in
            let okPressed: ((UIAlertAction) -> Void) = { _ in
                self.dismiss(animated: true, completion: nil)
            }
            self.present(HelpfulFunctions.createAlert(for: "Post Created!", okHandler: okPressed), animated: true, completion: nil)
            }.catch { (error) in
                var errorText = ""
                if let msgError = error as? MessageError {errorText = msgError.message} else {errorText = "Error"}
                self.present(HelpfulFunctions.createAlert(for: errorText), animated: true, completion: nil)
        }
    }
    
}


