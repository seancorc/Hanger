//
//  FilterStateManager.swift
//  Hanger
//
//  Created by Sean Corcoran on 8/29/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation

public enum FilterType: CaseIterable {
    case Price
    case Distance
    case Types
    case Categories
}

class FilterStateManager {
    var stackOfNewlySelectedRows = [FilterType : [IndexPath]]()
    var stackOfDeselectedRows = [FilterType : [IndexPath]]()
    var initalToggleStates = [FilterType : Bool]()
    var initalMinPriceTextFieldText: String = ""
    var initalMaxPriceTextFieldText: String = ""
    
    private init() {
        FilterType.allCases.forEach {
            stackOfNewlySelectedRows[$0] = []
            stackOfDeselectedRows[$0] = []
            initalToggleStates[$0] = true
        }
    }
    
    static private let manager = FilterStateManager()
    
    static func stateManager() -> FilterStateManager {
        return manager
    }
    
    func resetStateManager() {
        FilterType.allCases.forEach {
            stackOfNewlySelectedRows[$0] = []
            stackOfDeselectedRows[$0] = []
        }
    }
    
}
