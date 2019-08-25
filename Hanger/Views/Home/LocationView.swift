//
//  LocationView.swift
//  Hanger
//
//  Created by Sean Corcoran on 8/24/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit
import MapKit

class LocationView: UIView {
    var roundRect: CGRect!
    
    override func draw(_ rect: CGRect) {
        roundRect = CGRect(x: rect.minX, y: rect.minY + rect.height * 1/12, width: rect.width, height: rect.height * 11/12)
        let roundRectBez = UIBezierPath(roundedRect: roundRect, cornerRadius: 10.0)
        let triangleBez = UIBezierPath()
        let padding = roundRect.width / 20
        let triangleWidth = roundRect.width / 10
        triangleBez.move(to: CGPoint(x: roundRect.minX + padding, y: roundRect.minY))
        triangleBez.addLine(to: CGPoint(x: roundRect.minX + triangleWidth / 2 + padding, y: rect.minY))
        triangleBez.addLine(to: CGPoint(x: roundRect.minX + triangleWidth + padding, y: roundRect.minY))
        triangleBez.close()
        roundRectBez.append(triangleBez)
        let bez = roundRectBez
        UIColor(white: 0.9, alpha: 1).setFill()
        bez.fill()
        super.draw(rect)
    }
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor =  0.5
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "Location"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 24 * Global.ScaleFactor)
        return label
    }()
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    override func didMoveToSuperview() {
        
        self.addSubview(cityLabel)
        
        self.addSubview(mapView)
        
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mapView.layer.cornerRadius = mapView.frame.width / 12
    }
    
    func configureSubviews(labelText: String, mapViewCameraCoords: CLLocation) {
        cityLabel.text = labelText
        let distance = CLLocationDistance(floatLiteral: 1609.34 * 5)
        let camera = MKMapCamera(lookingAtCenter: mapViewCameraCoords.coordinate, fromDistance: distance, pitch: 0, heading: 0)
        mapView.setCamera(camera, animated: false)
    }

    func setupConstraints() {
        let padding = 32 * Global.ScaleFactor
        
        cityLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(padding)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        mapView.snp.makeConstraints { (make) in
            make.top.equalTo(cityLabel.snp.bottom).offset(padding / 4)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalToSuperview().multipliedBy(0.6)
        }
    }
    
}
