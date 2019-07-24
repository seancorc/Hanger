//
//  TabBarController.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/1/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class TabBarController: UITabBarController {
    var userManager: UserManager!
    var networkManager: NetworkManager!
    var userDefaults: UserDefaults!
    var keychainWrapper: KeychainWrapper!
    
    init(userManager: UserManager = .currentUser(), networkManager: NetworkManager = .shared(), userDefaults: UserDefaults = .standard, keychainWrapper: KeychainWrapper = .standard) {
        self.userManager = userManager
        self.networkManager = networkManager
        self.userDefaults = userDefaults
        self.keychainWrapper = keychainWrapper
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tabBar.backgroundImage = UIImage.image(with: .clear) //Setup for frosty looking tab bar - .image(with: .clear) comes from HelpfulExtensions file
        let frost = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        frost.frame = CGRect(x: 0, y: 0, width: self.tabBar.bounds.width, height:self.tabBar.bounds.height + 50)
        frost.autoresizingMask = .flexibleWidth
        self.tabBar.insertSubview(frost, at: 0)
        
        setUpTabBar()
    }
    
    func setUpTabBar() {
        tabBar.tintColor = UIColor(red: 10/255, green: 50/255, blue: 160/255, alpha: 1)
        
        let homePage = HomeViewController()
        let homeNavController = UINavigationController(rootViewController: homePage)
        let homeIcon = UIImage(named: "homeicon")!.withRenderingMode(.alwaysTemplate)
        let homeTabItem = configureTabItem(title: "Home", icon: homeIcon)
        homeNavController.tabBarItem = homeTabItem
        
        let createSalePage = CreateSaleViewController()
        let createSaleIcon = UIImage(named: "createsaleicon")!.withRenderingMode(.alwaysTemplate)
        let createSaleTabItem = configureTabItem(title: "Create Sale", icon: createSaleIcon)
        createSalePage.tabBarItem = createSaleTabItem
        
        let messagesPage = MessageViewController(userManager: self.userManager)
        let messagesNavController = UINavigationController(rootViewController: messagesPage)
        let messagesIcon = UIImage(named: "chaticon")!.withRenderingMode(.alwaysTemplate)
        let messagesTabItem = configureTabItem(title: "Messages", icon: messagesIcon)
        messagesNavController.tabBarItem = messagesTabItem
        
        let accountPage = AccountViewController(userManager: self.userManager, networkManager: self.networkManager, userDefaults: self.userDefaults, keychainWrapper: .standard)
        let accountNavController = UINavigationController(rootViewController: accountPage)
        let accountIcon = UIImage(named: "accounticon")!.withRenderingMode(.alwaysTemplate)
        let accountTabItem = configureTabItem(title: "Account", icon: accountIcon)
        accountNavController.tabBarItem = accountTabItem
        
        let viewsArray = [homeNavController, createSalePage, messagesNavController, accountNavController]
        self.viewControllers = viewsArray
        
    }
    
    func configureTabItem(title: String, icon: UIImage) -> UITabBarItem {
        let tabItem = UITabBarItem(title: title, image: icon, selectedImage: nil)
        tabItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.gray], for: UIControl.State.normal)
        tabItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 10/255, green: 50/255, blue: 160/255, alpha: 1)], for: UIControl.State.selected)
        return tabItem
    }
    
}

