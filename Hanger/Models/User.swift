//
//  User.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/7/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import UIKit

struct usersResponse: Codable {
    var data: [User]
}

struct singleUserResponse: Codable {
    var data: User
    var success: Bool
}

struct User: Codable {
    var id: Int
    var email: String
    var password: String
    var username: String
    var latitude: Float
    var longitude: Float
}
