//
//  UserManager.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/10/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation

class UserManager {
    
    static private let currentUserManager = UserManager()
    
    static func currentUser() -> UserManager {
        return currentUserManager
    }
    
    var user: User!
    
}
