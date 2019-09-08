//
//  PagingViewController.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/16/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit
import Koloda
import MapKit.MKGeometry

//Todo: What happens when user swipes right
class HomeKolodaViewController: UIViewController, KolodaViewDelegate, KolodaViewDataSource {
    var homeView: HomeView!
    var clothingPosts = [ClothingPost]()
    var locationViewGeoCoder: CLGeocoder!
    var currentKolodaIndex = 0
    var tapGestureRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        homeView = HomeView()
        homeView.kolodaView.delegate = self
        homeView.kolodaView.dataSource = self
        
        locationViewGeoCoder = CLGeocoder()
        
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return clothingPosts.count
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let kolodaView = KolodaCardView()
        kolodaView.isUserInteractionEnabled = true
        setupCollectionViewControl(collectionView: kolodaView.collectionView, index: index)
        let clothingPost = clothingPosts[index]
        kolodaView.configureSubviews(name: clothingPost.name, brand: clothingPost.brand, sellerProfilePicURL: clothingPost.user.profilePictureURLString, sellerName: clothingPost.user.username, price: String(clothingPost.price))
        return kolodaView
    }
    
    
    func koloda(_ koloda: KolodaView, didShowCardAt index: Int) {
        setDescriptionForCard(index: index)
        setLocationViewForCard(index: index)
        homeView.pagingControl.numberOfPages = clothingPosts[index].imageURLs.count
        homeView.pagingControl.currentPage = 0
        UIView.animate(withDuration: 0.3) {
            self.homeView.pagingControl.layoutIfNeeded()
        }
        if let view = koloda.viewForCard(at: index + 1) as? KolodaCardView {
            view.collectionView.collectionViewLayout.invalidateLayout()
            view.layoutIfNeeded()
        }
        
    }
    
    private func setDescriptionForCard(index: Int) {
        homeView.descriptionButton.isHidden = clothingPosts[index].description == nil
        let description = clothingPosts[homeView.kolodaView.currentCardIndex].description ?? ""
        let attrText = NSMutableAttributedString(attributedString: homeView.descriptionLabel.attributedText ?? NSAttributedString())
        attrText.append(NSAttributedString(string: description, attributes: [NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 20 * Global.ScaleFactor) as Any]))
        homeView.descriptionLabel.attributedText = attrText
    }
    
    private func setLocationViewForCard(index: Int) {
        let lat = CLLocationDegrees(floatLiteral: Double(clothingPosts[index].lat))
        let longt = CLLocationDegrees(floatLiteral: Double(clothingPosts[index].longt))
        let clothingPostLocation = CLLocation(latitude: lat, longitude: longt)
        locationViewGeoCoder.reverseGeocodeLocation(clothingPostLocation) { (placemark, error) in
            if let err = error {
                print(err.localizedDescription)
            } else {
                let city = placemark?[0].locality ?? ""
                let state = placemark?[0].administrativeArea ?? ""
                let postalCode = placemark?[0].postalCode ?? ""
                self.homeView.locationView.configureSubviews(labelText: "\(city), \(state)\n\(postalCode)", mapViewCameraCoords: clothingPostLocation)
                self.homeView.locationView.layoutIfNeeded()
            }
        }
    }
    
    func kolodaPanBegan(_ koloda: KolodaView, card: DraggableCardView) {
        UIView.animate(withDuration: 0.3) {
            self.homeView.pagingControl.alpha = 0
            self.homeView.descriptionButton.alpha = 0
            self.homeView.locationButton.alpha = 0
        }
        if homeView.locationView.transform.ty >= 0 {homeView.dismissLocation()}
        if homeView.descriptionLabel.transform.ty <= 0 {homeView.dismissDescription()}
    }
    
    func kolodaPanFinished(_ koloda: KolodaView, card: DraggableCardView) {
        UIView.animate(withDuration: 0.3) {
            self.homeView.pagingControl.alpha = 1
            self.homeView.descriptionButton.alpha = 1
            self.homeView.locationButton.alpha = 1
        }
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        if homeView.locationView.transform.ty >= 0 {homeView.dismissLocation()}
        if homeView.descriptionLabel.transform.ty <= 0 {homeView.dismissDescription()}
    }
    
//    func koloda(_ koloda: KolodaView, draggedCardWithPercentage finishPercentage: CGFloat, in direction: SwipeResultDirection) {
//        if direction == SwipeResultDirection.right {
//            guard let card = koloda.viewForCard(at: koloda.currentCardIndex) as? KolodaCardView else {return}
//            card.priceLabel.textColor = UIColor(red: calculatedValue, green: 1 - ((100 - finishPercentage) / 100.0), blue: calculatedValue, alpha: 1)
//        }
//    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        homeView.descriptionLabel.attributedText = HomeView.defaultDescriptionText
    }
    
    
}

extension HomeKolodaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func setupCollectionViewControl(collectionView: UICollectionView, index: Int) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Global.ThemeColor
        collectionView.tag = index
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: Global.CellID)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothingPosts[collectionView.tag].imageURLs.count
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let y = targetContentOffset.pointee.y
        self.homeView.pagingControl.currentPage = Int(y / scrollView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Global.CellID, for: indexPath) as! CardCollectionViewCell
        let clothingImageURL = clothingPosts[collectionView.tag].imageURLs[indexPath.row]
        cell.configureCell(imageURL: clothingImageURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

}
