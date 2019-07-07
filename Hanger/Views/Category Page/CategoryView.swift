//
//  CategoryView.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/5/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class CategoryView: UIView {
    var collectionView: UICollectionView!
    
    
    init() {
        super.init(frame: .zero)
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupSubviews() {
        self.backgroundColor = .white
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        self.addSubview(collectionView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
        }
        
    }
    
}
