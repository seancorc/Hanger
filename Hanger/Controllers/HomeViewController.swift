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
        return 5
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let view = KolodaCardView()
        view.layer.cornerRadius = self.view.frame.height * 0.015
        return view
    }
    
}

extension HomeViewController {
    func setupNavBar() {
        //Making Nav Bar transparent
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "Hanger"))
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view.frame.width * 0.4)
            make.height.equalTo(self.view.frame.height * 0.03)
        }
        self.navigationItem.titleView = titleImageView
        
        navigationController?.navigationBar.barTintColor = Global.themeColor
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

