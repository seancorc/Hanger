//
//  Filters.swift
//  Hanger
//
//  Created by Sean Corcoran on 8/15/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation

enum Prices: String, CaseIterable {
    case one = "$"
    case two = "$$"
    case three = "$$$"
    case four = "$$$$"
}

enum Distances: String, CaseIterable {
    case five = "5 Mi"
    case ten = "10 Mi"
    case fifteen = "15 Mi"
    case twentyfive = "25 Mi"
    case fifty = "50 Mi"
}

enum Types: String, CaseIterable {
    case men = "Men"
    case women = "Women"
    case neutral = "Gender Neutral"
}

enum Categories: String, CaseIterable { //Collegiate apparel
    case casual = "Casual"
    case workout = "Workout"
    case swimwear = "Swimwear"
    case headgear = "Headgear"
    case formal = "Formal"
    case footwear = "Footwear"
    case accesssories = "Accessories"
    case other = "Other"
}
