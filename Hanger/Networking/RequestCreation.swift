//
//  RequestBuilding.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/9/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import Alamofire

protocol Request {
    var path: String { get }
    
    var method: HTTPMethod { get }
    
    var parameters: RequestParameters { get }
    
    var headers: [String: String] { get }
}


enum RequestParameters {
    case body(_ : [String:String])
    case url(_ : [String:String])
    case none
}

enum UserRequests: Request {
    
    case login(email: String, password: String)
    case signUp(email: String, username: String, password: String)
    case updateInfo(userID: Int, newEmail: String, newUsername: String)
    
    var path: String {
        switch self {
        case .login(_, _): return "/user/login/"
        case .signUp(_, _, _): return "/user/signup/"
        case .updateInfo(_, _, _): return "/user/updateinfo/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login(_, _): return HTTPMethod.post
        case .signUp(_, _, _): return HTTPMethod.post
        case .updateInfo(_, _, _): return HTTPMethod.put
        }
    }
    
    var parameters: RequestParameters {
        switch self {
        case .login(let email, let password): return .body(["email" : email, "password" : password])
        case .signUp(let email, let username, let password): return .body(["email" : email, "password" : password, "username": username])
        case .updateInfo(let userID, let newEmail, let newUsername): return .body(["userID": "\(userID)", "newEmail": newEmail, "newUsername": newUsername])
        }
    }
    
    var headers: [String : String] {
        return [:]
    }
    
}
