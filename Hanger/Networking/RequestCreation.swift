//
//  RequestBuilding.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/9/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import Alamofire

public protocol Request {
    var path: String { get }
    
    var method: HTTPMethod { get }
    
    var parameters: [String: String] { get }
    
    var headers: [String: String] { get }
}


public enum UserRequests: Request {
    
    case login(email: String, password: String)
    case signUp(email: String, username: String, password: String)
    
    public var path: String {
        switch self {
        case .login(_, _): return "/user/login/"
        case .signUp(_, _, _): return "/user/signup/"
        }
    }
    
    public var method: HTTPMethod {return HTTPMethod.post}
    
    public var parameters: [String: String] {
        switch self {
        case .login(let email, let password): return ["email" : email, "password" : password]
        case .signUp(let email, let username, let password): return ["email" : email, "password" : password, "username": username]
        }
    }
    
    public var headers: [String : String] {
        return [:]
    }
    
}
