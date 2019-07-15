//
//  HomeViewController.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/1/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit
import Koloda
import MapKit

class HomeViewController: UIViewController {
    var homeView: HomeView!
    var locationManager: CLLocationManager!
    var geoCoder: CLGeocoder!
    let hardcodedClothingItems: [SellableClothingItem] = [SellableClothingItem(name: "Black Nike Shirt", clothingImage: UIImage(named: "clothingitem1")!, sellerImage: #imageLiteral(resourceName: "sellerimage"), sellerName: "Josh Smith", price: 25), SellableClothingItem(name: "Barley Worn Lulu Leggings", clothingImage: UIImage(named: "clothingitem2")!, sellerImage: #imageLiteral(resourceName: "sellerimage"), sellerName: "Sarah Belmont", price: 33), SellableClothingItem(name: "Jordan Slip - Velcro", clothingImage: UIImage(named: "clothingitem3")!, sellerImage: #imageLiteral(resourceName: "sellerimage"), sellerName: "Jeffery Guthantam Haag", price: 100000)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        
        homeView = HomeView()
        homeView.translatesAutoresizingMaskIntoConstraints = false
        homeView.kolodaView.delegate = self
        homeView.kolodaView.dataSource = self
        view.addSubview(homeView)
        homeView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        setupLocationManagment()
        
        
    }
    
}

extension HomeViewController: KolodaViewDelegate, KolodaViewDataSource {
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return hardcodedClothingItems.count
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let kolodaView = KolodaCardView()
        kolodaView.layer.cornerRadius = self.view.frame.height * 0.015
        let sellableClothingItem = hardcodedClothingItems[index]
        kolodaView.configureSubviews(nameLabelText: sellableClothingItem.name, clothingImage: sellableClothingItem.clothingImage, sellerImage: sellableClothingItem.sellerImage, sellerName: sellableClothingItem.sellerName, price: sellableClothingItem.price)
        return kolodaView
    }
    
}

extension HomeViewController {
    func setupNavBar() {
        
        let titleImageView = UIImageView(image: UIImage(named: "Hanger"))
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view.frame.width * 0.4)
            make.height.equalTo(self.view.frame.height * 0.03)
        }
        self.navigationItem.titleView = titleImageView
        navigationController?.navigationBar.barTintColor = Global.ThemeColor
        
        let filterButton = UIButton()
        filterButton.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)
        filterButton.setTitle("Filter", for: .normal)
        filterButton.setTitleColor(.white, for: .normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: filterButton)
        
        
    }
    
    
    
    @objc func filterButtonPressed() {
        present(UINavigationController(rootViewController: FilterViewController()), animated: true, completion: nil)
    }
    
    
}

extension HomeViewController: CLLocationManagerDelegate {
    func setupLocationManagment() {
        locationManager = CLLocationManager()
        geoCoder = CLGeocoder()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = manager.location {
            geoCoder.reverseGeocodeLocation(location) { (placemark, error) in
                if let err = error {
                    print(err.localizedDescription)
                } else {
                    let city = placemark?[0].locality ?? ""
                    let state = placemark?[0].administrativeArea ?? ""
                    self.homeView.cityLabel.text = city + ", " + state
                    self.homeView.layoutIfNeeded()
                }
            }
        }
        
        
    }
}

