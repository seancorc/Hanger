//
//  FilterStateManager.swift
//  Hanger
//
//  Created by Sean Corcoran on 8/29/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation

public enum FilterType {
    case Price
    case Distance
    case Types
    case Categories
}

struct FilterStateManager {
    static var stackOfNewlySelectedRows = [FilterType : [IndexPath]]()
}
