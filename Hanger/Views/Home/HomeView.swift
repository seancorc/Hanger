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
    static let defaultDescriptionText = NSMutableAttributedString(string: "Description\n", attributes: [NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 24 * Global.ScaleFactor) as Any, NSAttributedString.Key.underlineStyle: 1])
    
    lazy var kolodaView: KolodaView = {
        let kolodaView = KolodaView()
        kolodaView.translatesAutoresizingMaskIntoConstraints = false
        kolodaView.backgroundColor = .clear
        return kolodaView
    }()
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16 * Global.ScaleFactor, weight: .bold)
        return label
    }()
    
    lazy var locationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "locationicon"), for: .normal)
        return button
    }()
    
    lazy var locationView: LocationView = {
        let locationView = LocationView()
        locationView.isUserInteractionEnabled = false
        locationView.backgroundColor = .clear
        locationView.translatesAutoresizingMaskIntoConstraints = false
        return locationView
    }()
    
    lazy var pagingControl: UIPageControl = {
        let pagingControl = UIPageControl()
        pagingControl.currentPage = 0
        pagingControl.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        pagingControl.pageIndicatorTintColor = UIColor.darkGray
        pagingControl.currentPageIndicatorTintColor = .white
        return pagingControl
    }()
    
    lazy var descriptionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "description"), for: .normal)
        return button
    }()
    
    lazy var descriptionLabel: DescriptionLabel = {
        let label = DescriptionLabel()
        label.numberOfLines = 0
        label.attributedText = HomeView.defaultDescriptionText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var descriptionLabelTransform: CGAffineTransform = {
        let trans1 =  CGAffineTransform(scaleX: 0, y: 0)
        let trans2 =  CGAffineTransform(translationX: descriptionLabel.intrinsicContentSize.width, y: descriptionLabel.intrinsicContentSize.height)
        return trans1.concatenating(trans2)
    }()
    
    lazy var locationViewTransform: CGAffineTransform = {
        let trans1 =  CGAffineTransform(scaleX: 0, y: 0)
        let trans2 =  CGAffineTransform(translationX: -descriptionLabel.intrinsicContentSize.width, y: -descriptionLabel.intrinsicContentSize.height)
        return trans1.concatenating(trans2)
    }()
    
    lazy var loadingLayer: CAShapeLayer = {
        let radius = UIScreen.main.bounds.width / 6
        let circularPath = UIBezierPath(arcCenter: UIApplication.shared.keyWindow!.center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = Global.ThemeColor.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = 0
        return shapeLayer
    }()
    
    var backgroundLoadingLayer: CAShapeLayer = {
        let radius = UIScreen.main.bounds.width / 6
        let circularPath = UIBezierPath(arcCenter: UIApplication.shared.keyWindow!.center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        return shapeLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        
        self.addSubview(cityLabel)
        
        self.addSubview(kolodaView)
        
        self.addSubview(locationButton)
        
        self.addSubview(pagingControl)
        
        locationView.transform = locationViewTransform
        self.addSubview(locationView)
        
        self.addSubview(descriptionButton)
        
        descriptionLabel.transform = descriptionLabelTransform
        self.addSubview(descriptionLabel)
        
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
        
        
        locationButton.snp.makeConstraints { (make) in
            make.leading.equalTo(kolodaView.snp.leading).offset(padding * 1.5)
            make.top.equalTo(kolodaView.snp.top).offset(padding * 1.5)
            make.size.equalTo(45 * Global.ScaleFactor)
        }
        
        locationView.snp.makeConstraints { (make) in
            make.width.equalTo(kolodaView.snp.width).multipliedBy(0.9)
            make.leading.equalTo(locationButton.snp.leading).offset(-padding)
            make.top.equalTo(locationButton.snp.bottom)
            make.height.equalTo(kolodaView.snp.height).multipliedBy(0.45)
        }
        
        pagingControl.snp.makeConstraints { (make) in
            make.leading.equalTo(kolodaView.snp.leading).offset(16 * Global.ScaleFactor)
            make.width.equalToSuperview().multipliedBy(0.015) //Need to set width or else width increases with number of pages
            make.centerY.equalToSuperview()
        }
        
        descriptionButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(kolodaView.snp.trailing).offset(-padding * 3)
            make.bottom.equalTo(kolodaView.snp.bottom).offset(-padding * 3)
            make.size.equalTo(65 * Global.ScaleFactor)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(descriptionButton.snp.top)
            make.width.equalTo(kolodaView.snp.width).multipliedBy(0.8)
            make.trailing.equalTo(descriptionButton.snp.trailing).offset(padding)
        }
        
    }
    
}

extension HomeView: CAAnimationDelegate {
    
    func deployDescription() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [.curveEaseInOut], animations: {
            self.descriptionLabel.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func dismissDescription() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            self.descriptionLabel.alpha = 0
        }, completion: {_ in
            self.descriptionLabel.transform = self.descriptionLabelTransform
            self.descriptionLabel.alpha = 1
        })
    }
    
    func deployLocation() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [.curveEaseInOut], animations: {
            self.locationView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func dismissLocation() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            self.locationView.alpha = 0
        }, completion: {_ in
            self.locationView.transform = self.locationViewTransform
            self.locationView.alpha = 1
        })
    }
    
    func fireLoadingAnimaton() {
        backgroundLoadingLayer.removeAnimation(forKey: "fade")
        loadingLayer.removeAnimation(forKey: "fade")
        
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
