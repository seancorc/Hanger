//
//  DescriptionView.swift
//  Hanger
//
//  Created by Sean Corcoran on 8/23/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import UIKit

class DescriptionLabel: UILabel {
    var roundRect:CGRect!
    override func drawText(in rect: CGRect) {
        super.drawText(in: roundRect)
    }
    override var intrinsicContentSize: CGSize {
        let origContentSize = super.intrinsicContentSize
        let heightOffset = 48 * Global.ScaleFactor
        return CGSize(width: origContentSize.width, height: origContentSize.height + heightOffset)
    }
    
    override func draw(_ rect: CGRect) {
        roundRect = CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height * 7/8)
        let roundRectBez = UIBezierPath(roundedRect: roundRect, cornerRadius: 10.0)
        let triangleBez = UIBezierPath()
        let padding = roundRect.width / 10
        let triangleWidth = roundRect.width / 10
        triangleBez.move(to: CGPoint(x: roundRect.maxX - triangleWidth - padding , y:roundRect.maxY))
        triangleBez.addLine(to: CGPoint(x: roundRect.maxX - triangleWidth / 2 - padding ,y:rect.maxY))
        triangleBez.addLine(to: CGPoint(x: roundRect.maxX - padding, y:roundRect.maxY))
        triangleBez.close()
        roundRectBez.append(triangleBez)
        let bez = roundRectBez
        UIColor(white: 0.9, alpha: 1).setFill()
        bez.fill()
        super.draw(rect)
    }
}
