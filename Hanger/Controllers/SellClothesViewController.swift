//
//  CreateSaleViewController.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/14/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class SellClothesViewController: UIViewController {
    var sellClothesView: SellClothesView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.6, alpha: 0.6)
        
        sellClothesView = SellClothesView()
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
    //fix
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.selectedRange = NSRange()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.textColor = .black
            textView.text = ""
            textView.toggleUnderline(nil)
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            print("here")
            if textView.text.isEmpty {
                textView.attributedText = sellClothesView.placeholderTextViewText
            }
        }
        
    }
}


extension SellClothesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setupCollectionViewControl() {
        sellClothesView.collectionView.delegate = self
        sellClothesView.collectionView.dataSource = self
        sellClothesView.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Global.CellID)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 6, height: self.view.frame.height * 0.08)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Global.CellID, for: indexPath)
        cell.backgroundColor = .purple
        return cell
    }
    
    
}
