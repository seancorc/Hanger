//
//  CategoriesViewController.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/5/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

struct ClothingCategory {
    let image: UIImage
    let text: String
}

class CategoriesViewController: UIViewController {
    var categoryView: CategoryView!
    let categories = [ClothingCategory(image: UIImage(named: "shirticon")!, text: "Shirts"), ClothingCategory(image: UIImage(named: "pantsicon")!, text: "Pants"), ClothingCategory(image: UIImage(named: "shorticon")!, text: "Shorts")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        
        categoryView = CategoryView()
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(categoryView)
        categoryView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        setupCollectionViewControl() //Must be called after categoryView is created
        
        
    }
    
    
}

extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setupCollectionViewControl() {
        categoryView.collectionView.delegate = self
        categoryView.collectionView.dataSource = self
        categoryView.collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: Global.CellID)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryView.collectionView.dequeueReusableCell(withReuseIdentifier: Global.CellID, for: indexPath) as! CategoryCollectionViewCell
        let clotingCategory = categories[indexPath.row]
        cell.configureCell(categoryImage: clotingCategory.image, categoryName: clotingCategory.text)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2.25), height: (UIScreen.main.bounds.height / 6.5))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.view.frame.height * 0.035
    }
    
    
}

extension CategoriesViewController: UITextFieldDelegate {
    
    func setupNavBar() {
        //Making Nav Bar transparent
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "Hanger"))
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view.frame.width * 0.4)
            make.height.equalTo(self.view.frame.height * 0.03)
        }
        self.navigationItem.titleView = titleImageView
        navigationController?.navigationBar.barTintColor = Global.ThemeColor
    }
    
}
