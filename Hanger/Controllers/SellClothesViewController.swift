//
//  CreateSaleViewController.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/14/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class SellClothesViewController: UIViewController {
    var sellClothesView: SellClothesView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.6, alpha: 0.6)
        
        sellClothesView = SellClothesView()
        sellClothesView.dismissButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
        sellClothesView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sellClothesView)
        sellClothesView.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.85)
        }
    }
    
    @objc func dismissButtonPressed() {
        view.backgroundColor = .clear //UI Purposes
        dismiss(animated: true, completion: nil)
    }

}
