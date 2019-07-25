//
//  User.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/7/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import UIKit

struct UserResponse: Codable {
    var data: User
}


struct User: Codable {
    var id: Int
    var email: String
    var username: String
}
