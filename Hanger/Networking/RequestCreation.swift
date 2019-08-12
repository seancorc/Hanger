//
//  RequestBuilding.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/9/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import Alamofire

enum UserRequests: Request {
    
    case login(email: String, password: String)
    case signUp(email: String, username: String, password: String)
    case updateInfo(newEmail: String, newUsername: String)
    case updatePassword(currentPassword: String, newPassword: String)
    case modifyProfilePicture(url: String) //-- IMPLEMENT WHEN S3 IS UP (UPLOAD TO S3 AND THEN PUT URL IN DB)
    case getPostsForUser
    
    var path: String {
        switch self {
        case .login(_, _): return "/user/login/"
        case .signUp(_, _, _): return "/user/signup/"
        case .updateInfo(_, _): return "/user/updateinfo/"
        case .updatePassword(_, _): return "/user/updatepassword/"
        case .modifyProfilePicture(_): return "/user/profilepicture/"
        case .getPostsForUser: return "/user/posts/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login(_, _): return HTTPMethod.post
        case .signUp(_, _, _): return HTTPMethod.post
        case .updateInfo(_, _): return HTTPMethod.put
        case .updatePassword(_, _): return HTTPMethod.put
        case .modifyProfilePicture(_): return HTTPMethod.put
        case .getPostsForUser: return HTTPMethod.get
        }
    }
    
    var parameters: RequestParameters {
        switch self {
        case let .login(email, password): return .body(["email" : email, "password" : password])
        case let .signUp(email, username, password): return .body(["email" : email, "password" : password, "username": username])
        case let .updateInfo(newEmail, newUsername): return .body(["newEmail": newEmail, "newUsername": newUsername])
        case let .updatePassword(currentPassword, newPassword): return .body(["currentPassword":currentPassword, "newPassword":newPassword])
        case let .modifyProfilePicture(url): return .body(["url":url])
        case .getPostsForUser: return .body([:])
        }
    }
    
    var headers: [String : String] {
        switch self {
        case .updateInfo(_, _): return ["Authorization": "Bearer \(UserDefaults.standard.value(forKey: UserDefaultKeys.token) ?? "")"]
        case .updatePassword(_, _): return ["Authorization": "Bearer \(UserDefaults.standard.value(forKey: UserDefaultKeys.token) ?? "")"]
        case .modifyProfilePicture(_): return ["Authorization": "Bearer \(UserDefaults.standard.value(forKey: UserDefaultKeys.token) ?? "")"]
        case .getPostsForUser: return ["Authorization": "Bearer \(UserDefaults.standard.value(forKey: UserDefaultKeys.token) ?? "")"]
        default: return [:]
        }
    }
    
}

enum SellClothesRequests: Request {
    case createPost(clothingType: String, category: String, name: String, brand: String, price: String, description: String?, imageURLs: [String])

    var path: String {
        switch self {
            case .createPost(_,_,_,_,_,_,_): return "/post/create/"
        }
    }

    var method: HTTPMethod {
        return HTTPMethod.post
    }

    var parameters: RequestParameters {
        switch self {
        case let .createPost(type, category, name, brand, price, description, imageURLs): return .body(["clothingType": type, "category": category, "name": name, "brand": brand, "price": price, "description": description, "imageURLs": imageURLs])
        }
    }

    var headers: [String : String] {
        return ["Authorization": "Bearer \(UserDefaults.standard.value(forKey: UserDefaultKeys.token) ?? "")"]
    }


}
