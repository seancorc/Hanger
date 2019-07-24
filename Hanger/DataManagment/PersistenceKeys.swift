//
//  UserDefaultKeys.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/21/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation

struct UserDefaultKeys {
    static let loggedIn = "LoggedIn"
    static let username = "Username"
    static let userID = "UserID"
}

struct KeychainKeys { //Implement for security later - https://medium.com/swift2go/application-security-musts-for-every-ios-app-dabf095b9c4f
    static let password = "Password"
    static let email = "Email"
}

