//
//  MessagesView.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/3/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class MessageView: UIView {
    var tableView: UITableView!
    
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        
        setupSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        self.addSubview(tableView)
        
        
        setupConstraints()
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
    }
    
    
    
}
