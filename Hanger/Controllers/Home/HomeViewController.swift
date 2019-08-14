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

class HomeViewController: HomeKolodaViewController {
    var locationManager: CLLocationManager!
    var geoCoder: CLGeocoder!
    var networkManager: NetworkManager!
    var userManager: UserManager!
    var updateLocationTask: UpdateUserLocationTask! //Cheeck for refrence cycle
    
    init(networkManager: NetworkManager = .shared(), userManager: UserManager = .currentUser()) {
        self.networkManager = networkManager
        self.userManager = userManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        
        homeView.translatesAutoresizingMaskIntoConstraints = false        
        view.addSubview(homeView)
        homeView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        homeView.fireLoadingAnimaton()
        
        
        updateLocationTask = UpdateUserLocationTask(lat: 34.0532, longt: -118.2437) //Default lat and long
        setupLocationManagment()
        
        let getNearbyPosts = GetNearbyPostsTask(radius: 10)
        getNearbyPosts.execute(in: networkManager).then { (clothingPosts) in
            print(clothingPosts)
            self.clothingPosts = clothingPosts
            self.homeView.kolodaView.reloadData()
            self.homeView.dismissLoadingAnimaton()
            }.catch { (error) in
                self.homeView.dismissLoadingAnimaton()
                var errorText = ""
                if let msgError = error as? MessageError {errorText = msgError.message} else {errorText = "Error"}
                self.present(HelpfulFunctions.createAlert(for: errorText), animated: true, completion: nil)
        }
        
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
        filterButton.setTitleColor(.darkGray, for: .highlighted)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
        
        let accountButton = UIButton() //TODO: make it small version of profile picture if they have one
        accountButton.translatesAutoresizingMaskIntoConstraints = false
        accountButton.snp.makeConstraints { (make) in
            make.width.equalTo(self.view.frame.width * 0.08)
            make.height.equalTo(accountButton.snp.width)
        }
        accountButton.addTarget(self, action: #selector(accountButtonPressed), for: .touchUpInside)
        accountButton.setImage(UIImage(named: "accounticon")!.withRenderingMode(.alwaysTemplate), for: .normal)
        accountButton.imageView?.tintColor = .white
        accountButton.imageView?.contentMode = .scaleToFill
        accountButton.imageView?.clipsToBounds = true
        accountButton.imageView?.layer.cornerRadius = self.view.frame.width * 0.04
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: accountButton)
        
    }
    
    @objc func filterButtonPressed() {
        present(UINavigationController(rootViewController: FilterViewController()), animated: true, completion: nil)
    }
    
    @objc func accountButtonPressed() {
        let accountController = AccountViewController(userManager: .currentUser(), networkManager: .shared(), userDefaults: .standard)
        present(UINavigationController(rootViewController: accountController), animated: true, completion: nil)
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
            locationManager.distanceFilter = CLLocationDistance(floatLiteral: 1609.34)
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
            let lat = Float(location.coordinate.latitude)
            let longt = Float(location.coordinate.longitude)
            updateLocationTask.lat = lat
            updateLocationTask.longt = longt
            updateLocationTask.execute(in: self.networkManager).then { (user) in
                self.userManager.user.lat = user.lat //Make sure DB and user are consistent
                self.userManager.user.longt = user.longt
                print(user)
                }.catch { (error) in
                    var errorText = ""
                    if let msgError = error as? MessageError {errorText = msgError.message} else {errorText = "Error"}
                    print(errorText)
            }
            
        }
    }
}
