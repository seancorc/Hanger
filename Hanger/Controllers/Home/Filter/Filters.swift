//
//  Filters.swift
//  Hanger
//
//  Created by Sean Corcoran on 8/15/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation

enum Prices: String, CaseIterable {
    case one = "$0 - $25"
    case two = "$25 - $50"
    case three = "$50 - $150"
    case four = "$150 - $300"
    case five = "$300+"
}

enum Distances: String, CaseIterable {
    case five = "5 Mi"
    case ten = "10 Mi"
    case fifteen = "15 Mi"
    case twentyfive = "25 Mi"
    case fifty = "50 Mi"
    case onehundred = "100 Mi"
    case threehundred = "300 Mi"
}

enum Types: String, CaseIterable {
    case men = "For Men"
    case women = "For Women"
    case neutral = "Neutral"
    case kids = "Kids"
}

enum Categories: String, CaseIterable { //Possbile Idea: Focus on Collegiate apparel
    case workout = "Workout"
    case swimwear = "Swimwear"
    case headgear = "Headgear"
    case footwear = "Footwear"
    case casual = "Casual"
    case formal = "Formal"
    case accesssories = "Accessories"
    case other = "Other"
}
