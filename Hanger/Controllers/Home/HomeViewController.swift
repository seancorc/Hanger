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

//TODO: Manage stream of cards, don't present ones already bought, use filters
class HomeViewController: HomeKolodaViewController, UIGestureRecognizerDelegate {
    var filterViewController: FilterViewController! //Purposefully creating retain cycle to save state of FilterViewController 
    var locationManager: CLLocationManager!
    var userGeoCoder: CLGeocoder!
    var networkManager: NetworkManager!
    var userManager: UserManager!
    var updateLocationTask: UpdateUserLocationTask! //Cheeck for refrence cycle
    var getNearbyPostsTask: GetNearbyPostsTask!
    var noPostsView: NoPostsView!
    
    
    init(networkManager: NetworkManager = .shared(), userManager: UserManager = .currentUser()) {
        self.networkManager = networkManager
        self.userManager = userManager
        self.filterViewController = FilterViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        homeView.descriptionButton.addTarget(self, action: #selector(descriptionButtonPressed), for: .touchUpInside)
        homeView.locationButton.addTarget(self, action: #selector(locationButtonPressed), for: .touchUpInside)
        view.addSubview(homeView)
        homeView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        updateLocationTask = UpdateUserLocationTask(lat: 34.0532, longt: -118.2437) //Default lat and long - Palos Verdes, CA
        setupLocationManagment()
        
        getNearbyPostsTask = GetNearbyPostsTask(radius: 10) //(Default Radius in Miles)
        self.getNearbyPosts()
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGestureRecognizer.isEnabled = false
        tapGestureRecognizer.delegate = self
        view.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    //Satisfies conflict between koloda draggable card view pan gesture recognizer and tap gesture recognizer
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func tapped() {
        homeView.dismissDescription()
        tapGestureRecognizer.isEnabled = false
    }
    
    @objc func descriptionButtonPressed(_ sender: Any) {
        tapGestureRecognizer.isEnabled = !tapGestureRecognizer.isEnabled
        if homeView.descriptionLabel.transform.ty > 0 {
            homeView.deployDescription()
        } else {
            homeView.dismissDescription()
        }
    }
    
    @objc func locationButtonPressed() {
        if homeView.locationView.transform.ty < 0 {
            homeView.deployLocation()
        } else {
            homeView.dismissLocation()
        }
    }
    
    private func getNearbyPosts(radius: Int = 10, silent: Bool = false) {
        if !silent {homeView.fireLoadingAnimaton()}
        getNearbyPostsTask.radius = radius
        getNearbyPostsTask.execute(in: networkManager).then { (clothingPosts) in
            if clothingPosts.count == 0 {
                self.addNoPostsView()
            } else {
                self.clothingPosts = clothingPosts
                self.homeView.kolodaView.reloadData()
            }
            if !silent {self.homeView.dismissLoadingAnimaton()}
            }.catch { (error) in
                if !silent {self.homeView.dismissLoadingAnimaton()}
                var errorText = ""
                if let msgError = error as? MessageError {errorText = msgError.message} else {errorText = "Error"}
                self.present(HelpfulFunctions.createAlert(for: errorText), animated: true, completion: nil)
        }
    }
    
    private func addNoPostsView() {
        noPostsView = NoPostsView()
        noPostsView.refreshButton.addTarget(self, action: #selector(refreshButtonPressed), for: .touchUpInside)
        noPostsView.translatesAutoresizingMaskIntoConstraints = false
        noPostsView.alpha = 0
        self.view.addSubview(noPostsView)
        noPostsView.snp.makeConstraints({ (make) in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.4)
            make.center.equalToSuperview()
        })
        UIView.animate(withDuration: 0.2, animations: {
            self.noPostsView.alpha = 1
        })
    }
    
    private func hideNoPostView() {
        UIView.animate(withDuration: 0.2) {
            self.noPostsView.alpha = 0
        }
    }
    
    @objc func refreshButtonPressed() {
        self.hideNoPostView()
        self.getNearbyPosts()
    }
    
}

extension HomeViewController: CLLocationManagerDelegate {
    func setupLocationManagment() {
        locationManager = CLLocationManager()
        userGeoCoder = CLGeocoder()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.distanceFilter = CLLocationDistance(floatLiteral: 1609.34 * 3) //3 miles
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = manager.location {
            userGeoCoder.reverseGeocodeLocation(location) { (placemark, error) in
                if let err = error {
                    print(err.localizedDescription)
                } else {
                    let city = placemark?[0].locality ?? ""
                    let state = placemark?[0].administrativeArea ?? ""
                    self.homeView.cityLabel.text = "\(city), \(state)"
                    self.homeView.layoutIfNeeded()
                }
            }
            let lat = Float(location.coordinate.latitude)
            let longt = Float(location.coordinate.longitude)
            updateUserLocation(lat: lat, longt: longt)
            
        }
    }
    
    private func updateUserLocation(lat: Float, longt: Float) {
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
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        filterButton.snp.makeConstraints { (make) in
            make.size.equalTo(35 * Global.ScaleFactor)
        }
        filterButton.setBackgroundImage(UIImage(named: "filtericon"), for: .normal)
        filterButton.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
        
        let accountButton = UIButton() //TODO: make it small version of profile picture if they have one
        accountButton.translatesAutoresizingMaskIntoConstraints = false
        accountButton.snp.makeConstraints { (make) in
            make.size.equalTo(35 * Global.ScaleFactor)
        }
        accountButton.addTarget(self, action: #selector(accountButtonPressed), for: .touchUpInside)
        accountButton.setImage(UIImage(named: "accounticon"), for: .normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: accountButton)
        
    }
    
    @objc func filterButtonPressed() {
        present(UINavigationController(rootViewController: self.filterViewController), animated: true, completion: nil)
    }
    
    @objc func accountButtonPressed() {
        let accountController = AccountViewController(userManager: .currentUser(), networkManager: .shared(), userDefaults: .standard)
        present(UINavigationController(rootViewController: accountController), animated: true, completion: nil)
    }
    
}
