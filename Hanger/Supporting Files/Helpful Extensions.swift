//
//  Helpful Extensions.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/1/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import UIKit


extension Date {
    private func localizedDescription(dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .medium, in timeZone: TimeZone = .current, locale: Locale = .current) -> String {
        Formatter.date.locale = locale
        Formatter.date.timeZone = timeZone
        Formatter.date.dateStyle = dateStyle
        Formatter.date.timeStyle = timeStyle
        return Formatter.date.string(from: self)
    }
    
    
    
    var localizedDescription: String { return localizedDescription() }
    
    var mediumDate: String {return localizedDescription(dateStyle: .medium, timeStyle: .none)}
    var fullDate:  String { return localizedDescription(dateStyle: .full, timeStyle: .none)  }
    var shortDate: String { return localizedDescription(dateStyle: .short, timeStyle: .none)  }
    var fullTime:  String { return localizedDescription(dateStyle: .none, timeStyle: .full)  }
    var shortTime: String { return localizedDescription(dateStyle: .none, timeStyle: .short)   }
    var fullDateTime:  String { return localizedDescription(dateStyle: .full, timeStyle: .full)  }
    var shortDateTime: String { return localizedDescription(dateStyle: .short, timeStyle: .short)  }
}


extension Formatter {
    static let date = DateFormatter()
}

extension TimeZone {
    static let gmt = TimeZone(secondsFromGMT: 0)!
}


extension UIImage { //Used to make frosty tabBar
    static func image(with color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image ?? UIImage(named: "Hanger")!
    }
    
    func scale(to newSize: CGSize) -> UIImage {
        let newSize = CGSize(width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension String {
    func validateText(validationType: ValidatorType) throws -> String {
        let validator = AppValidator.validatorFor(type: validationType)
        return try validator.validate(self)
    }
}

extension UITableView {
    func sizeHeaderToFit(padding: CGFloat) {
        guard let headerView = self.tableHeaderView else {return}
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height + padding
        var frame = headerView.frame
        frame.size.height = height
        headerView.frame = frame
        
        self.tableHeaderView = headerView
    }
}

extension UIView {
    
    /**
     Changes the view's UI to tell the user that input is needed
    */
    func needsInputBeforeContinuing() {
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1
        self.shake()
    }
    
    /**
     Reverses effects of a call to 'needsInputBeforeContinuing'
     */
    func inputGiven(borderColor: CGColor? = nil, borderWidth: CGFloat = 0) {
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWidth
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.3
        animation.values = [-10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

