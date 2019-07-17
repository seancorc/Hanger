//
//  PagingViewController.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/16/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit
import Koloda

class HomeKolodaViewController: UIViewController, KolodaViewDelegate, KolodaViewDataSource {
    var homeView: HomeView!
    let hardcodedClothingItems: [SellableClothingItem] = [SellableClothingItem(name: "Black Nike Shirt", clothingImages: [UIImage(named: "clothingitem1")!, UIImage(named: "clothingitem1")!, UIImage(named: "clothingitem1")!, UIImage(named: "clothingitem1")!], sellerImage: #imageLiteral(resourceName: "sellerimage"), sellerName: "Josh Smith", price: 25), SellableClothingItem(name: "Barley Worn Lulu Leggings", clothingImages: [UIImage(named: "clothingitem2")!, UIImage(named: "clothingitem2")!, UIImage(named: "clothingitem2")!, UIImage(named: "clothingitem2")!], sellerImage: #imageLiteral(resourceName: "sellerimage"), sellerName: "Sarah Belmont", price: 33), SellableClothingItem(name: "Jordan Slip - Velcro", clothingImages: [UIImage(named: "clothingitem3")!, UIImage(named: "clothingitem3")!, UIImage(named: "clothingitem3")!, UIImage(named: "clothingitem3")!], sellerImage: #imageLiteral(resourceName: "sellerimage"), sellerName: "Jeffery Guthantam Haag", price: 100000)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeView = HomeView()
        homeView.kolodaView.delegate = self
        homeView.kolodaView.dataSource = self
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return hardcodedClothingItems.count
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let kolodaView = KolodaCardView()
        setupCollectionViewControl(collectionView: kolodaView.collectionView)
        let sellableClothingItem = hardcodedClothingItems[index]
        kolodaView.configureSubviews(nameLabelText: sellableClothingItem.name, sellerImage: sellableClothingItem.sellerImage, sellerName: sellableClothingItem.sellerName, price: sellableClothingItem.price)
        return kolodaView
    }
    
}

extension HomeKolodaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func setupCollectionViewControl(collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: Global.CellID)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.y
        self.homeView.pagingControl.currentPage = Int(x / scrollView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Global.CellID, for: indexPath) as! CardCollectionViewCell
        cell.configureCell(image: #imageLiteral(resourceName: "clothingitem2"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

}
