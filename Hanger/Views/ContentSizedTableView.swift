//
//  ContentSizedTableView.swift
//  Carbon38
//
//  Created by dev on 6/20/19.
//  Copyright © 2019 Carbon38. All rights reserved.
//

import Foundation
import UIKit

class ContentSizedTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}

