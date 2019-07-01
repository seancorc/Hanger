//
//  HomeViewController.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/1/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit
import Koloda

class HomeViewController: UIViewController {
    var homeView: HomeView!
    
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
        
        
    }
    
}

extension HomeViewController: KolodaViewDelegate, KolodaViewDataSource {
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return 5
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let view = KolodaCardView()
        return view
    }
    
}

extension HomeViewController {
    func setupNavBar() {
        //Making Nav Bar transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.navigationItem.title = "Clothes Near Me"
    }
    
}

