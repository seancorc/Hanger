//
//  TabBarController.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/1/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    var userManager: UserManager!
    var networkManager: NetworkManager!
    var userDefaults: UserDefaults!
    
    init(userManager: UserManager = .currentUser(), networkManager: NetworkManager = .shared(), userDefaults: UserDefaults = .standard) {
        self.userManager = userManager
        self.networkManager = networkManager
        self.userDefaults = userDefaults
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        self.tabBar.backgroundImage = UIImage.image(with: .clear) //Setup for frosty looking tab bar - .image(with: .clear) comes from HelpfulExtensions file
        let frost = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        frost.frame = CGRect(x: 0, y: 0, width: self.tabBar.bounds.width, height:self.tabBar.bounds.height + 50)
        frost.autoresizingMask = .flexibleWidth
        self.tabBar.insertSubview(frost, at: 0)
        
        setUpTabBar()
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: SellClothesViewController.self) {
            let vc =  SellClothesViewController()
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    
    func setUpTabBar() {
        tabBar.tintColor = Global.ThemeColor
        
        let homePage = HomeViewController()
        let homeNavController = UINavigationController(rootViewController: homePage)
        let homeIcon = UIImage(named: "homeicon")!.withRenderingMode(.alwaysTemplate)
        let homeTabItem = configureTabItem(title: "Home", icon: homeIcon)
        homeTabItem.tag = 0
        homeNavController.tabBarItem = homeTabItem
        
        let sellClothesPage = SellClothesViewController()
        let createSaleTabItem = configureCenterTabItem()
        createSaleTabItem.tag = 1
        sellClothesPage.tabBarItem = createSaleTabItem
        
        let messagesPage = MessageViewController(userManager: self.userManager)
        let messagesNavController = UINavigationController(rootViewController: messagesPage)
        let messagesIcon = UIImage(named: "chaticon")!.withRenderingMode(.alwaysTemplate)
        let messagesTabItem = configureTabItem(title: "Messages", icon: messagesIcon)
        messagesTabItem.tag = 2
        messagesNavController.tabBarItem = messagesTabItem
        
//        let accountPage = AccountViewController(userManager: self.userManager, networkManager: self.networkManager, userDefaults: self.userDefaults)
//        let accountNavController = UINavigationController(rootViewController: accountPage)
//        let accountIcon = UIImage(named: "accounticon")!.withRenderingMode(.alwaysTemplate)
//        let accountTabItem = configureTabItem(title: "Account", icon: accountIcon)
//        accountNavController.tabBarItem = accountTabItem
        
        let viewsArray = [homeNavController, sellClothesPage, messagesNavController]
        self.viewControllers = viewsArray
        
    }
    
    private func configureTabItem(title: String, icon: UIImage) -> UITabBarItem {
        let tabItem = UITabBarItem(title: title, image: icon, selectedImage: nil)
        tabItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.gray], for: UIControl.State.normal)
        tabItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : Global.ThemeColor], for: UIControl.State.selected)
        return tabItem
    }
    
    private func configureCenterTabItem() -> UITabBarItem {
        let tabItem = UITabBarItem(title: nil, image: UIImage(named: "sellclothesicon"), selectedImage: nil)
        tabItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
        return tabItem
    }
    
}

