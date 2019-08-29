//
//  Filters.swift
//  Hanger
//
//  Created by Sean Corcoran on 8/15/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation

enum Distances: Int, CaseIterable {
    case five = 5
    case ten = 10
    case fifteen = 15
    case twentyfive = 25
    case fifty = 50
    case onehundred = 100
    case threehundred = 300
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
