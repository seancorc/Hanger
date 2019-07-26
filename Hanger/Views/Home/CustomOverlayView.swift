//
//  CustomOverlayView.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/25/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import Koloda


class CustomOverlayView: OverlayView {
    
    lazy var overlayImageView: UIImageView! = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        }()
    
    override var overlayState: SwipeResultDirection?  {
        didSet {
            switch overlayState {
            case .right? :
                overlayImageView.image = UIImage(named: "swiperight")
            default:
                overlayImageView.image = nil
            }
            
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.addSubview(overlayImageView)
        overlayImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalToSuperview().multipliedBy(0.6)
        }
    }
    
}
