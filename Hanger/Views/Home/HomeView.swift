//
//  HomeView.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/1/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit
import Koloda
import SnapKit

class HomeView: UIView {
    var kolodaView: KolodaView!
    var cityLabel: UILabel!
    var pagingControl: UIPageControl!
    var loadingLayer: CAShapeLayer!
    var backgroundLoadingLayer: CAShapeLayer!
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        
        setupSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupSubviews() {
        cityLabel = UILabel()
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = UIFont.systemFont(ofSize: 16 * Global.ScaleFactor, weight: .bold)
        self.addSubview(cityLabel)
        
        kolodaView = KolodaView()
        kolodaView.translatesAutoresizingMaskIntoConstraints = false
        kolodaView.backgroundColor = .clear
        self.addSubview(kolodaView)
        
        pagingControl = UIPageControl()
        pagingControl.currentPage = 0
        pagingControl.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        pagingControl.pageIndicatorTintColor = UIColor.darkGray
        pagingControl.currentPageIndicatorTintColor = .white
        self.addSubview(pagingControl)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        let padding = 8 * Global.ScaleFactor
        
        cityLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.height.equalToSuperview().multipliedBy(0.05)
        }
        
        kolodaView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.9)
            make.top.equalTo(cityLabel.snp.bottom).offset(padding)
        }
        
        
        pagingControl.snp.makeConstraints { (make) in
            make.leading.equalTo(kolodaView.snp.leading).offset(16 * Global.ScaleFactor)
            make.width.equalToSuperview().multipliedBy(0.015) //Need to set width or else width increases with number of pages
            make.centerY.equalToSuperview()
        }
    }
    
    
}

extension HomeView: CAAnimationDelegate {
    func fireLoadingAnimaton() {
        let radius = UIScreen.main.bounds.width / 6
        backgroundLoadingLayer = CAShapeLayer()
        loadingLayer = CAShapeLayer()
        backgroundLoadingLayer.removeAnimation(forKey: "fade")
        loadingLayer.removeAnimation(forKey: "fade")
        let circularPath = UIBezierPath(arcCenter: UIApplication.shared.keyWindow!.center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        backgroundLoadingLayer.path = circularPath.cgPath
        
        backgroundLoadingLayer.strokeColor = UIColor.black.cgColor
        backgroundLoadingLayer.lineWidth = 10
        backgroundLoadingLayer.fillColor = UIColor.clear.cgColor
        backgroundLoadingLayer.lineCap = CAShapeLayerLineCap.round
        
        loadingLayer.path = circularPath.cgPath
        loadingLayer.strokeColor = Global.ThemeColor.cgColor
        loadingLayer.lineWidth = 10
        loadingLayer.fillColor = UIColor.clear.cgColor
        loadingLayer.lineCap = CAShapeLayerLineCap.round
        loadingLayer.strokeEnd = 0
        
        let circle1Animation = CABasicAnimation(keyPath: "strokeEnd")
        circle1Animation.fromValue = 0
        circle1Animation.toValue = 1
        circle1Animation.duration = 1.5
        circle1Animation.fillMode = CAMediaTimingFillMode.forwards
        circle1Animation.isRemovedOnCompletion = false
        
        let circle2Animation = CABasicAnimation(keyPath: "strokeStart")
        circle2Animation.fromValue = 0
        circle2Animation.toValue = 1
        circle2Animation.duration = 1.5
        circle2Animation.beginTime = 1.5
        circle2Animation.fillMode = CAMediaTimingFillMode.forwards
        circle2Animation.isRemovedOnCompletion = false
        
        let animGroup = CAAnimationGroup()
        animGroup.duration = 3
        animGroup.repeatCount = .infinity
        animGroup.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animGroup.animations = [circle2Animation, circle1Animation]
        
        self.layer.addSublayer(backgroundLoadingLayer)
        self.layer.addSublayer(loadingLayer)
        loadingLayer.add(animGroup, forKey: "loading")
    }
    
    func dismissLoadingAnimaton() {
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.delegate = self
        fade.fromValue = 1
        fade.toValue = 0
        fade.duration = 0.5
        fade.fillMode = CAMediaTimingFillMode.forwards
        fade.isRemovedOnCompletion = false
        
        loadingLayer.add(fade, forKey: "fade")
        backgroundLoadingLayer.add(fade, forKey: "fade")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        loadingLayer.removeAnimation(forKey: "loading")
    }
}
