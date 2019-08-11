//
//  ClothingItem.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/3/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import UIKit

struct SellableClothingItem {
    var name: String
    var brand: String
    var clothingImages: [UIImage]
    var sellerImage: UIImage
    var sellerName: String
    var price: Int
}

struct ClothingPostResponse: Codable {
    var data: ClothingPost
}


struct ClothingPost: Codable {
    var id: Int
    var clothingType: String
    var category: String
    var name: String
    var brand: String
    var price: String
    var description: String?
    var user: User
    var imageURLs: [String]
    
}
