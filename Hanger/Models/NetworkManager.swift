//
//  File.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/7/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import MapKit
import Alamofire

fileprivate let signUpEndpoint = "http://localhost:5000/api/user/signup/"
fileprivate let loginEndpoint = "http://localhost:5000/api/user/login/"


class NetworkManager {
    
    static func login(email: String, password: String, completion: @escaping (User, Bool) -> Void) {
        let parameters: [String:Any] = [
            "email": email,
            "password": password
        ]
        Alamofire.request(loginEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [:]).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                do {
                    let user = try jsonDecoder.decode(singleUserResponse.self, from: data)
                    completion(user.data, user.success)
                }
                catch {
                    print(error)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func signUp(email: String, username: String, password: String, location: CLLocation,completion: @escaping (User) -> Void) {
        let parameters: [String:Any] = [
            "email": email,
            "password": password,
            "username": username,
            "latitude": location.coordinate.latitude,
            "longitude": location.coordinate.longitude
        ]
        Alamofire.request(signUpEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [:]).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                do {
                    let user = try jsonDecoder.decode(singleUserResponse.self, from: data)
                    completion(user.data)
                }
                catch {
                    print(error)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
