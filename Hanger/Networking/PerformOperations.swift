//
//  PerformOperations.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/10/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation

//Needs to be fixed - effectivley get network errors
protocol Operation {
    
    associatedtype OutputType
    
    var request: Request { get }
    
    func execute(in dispatcher: Dispatcher, completion: @escaping (_ output: OutputType?, _ error: MessageError?) -> Void)
}

class LoginTask: Operation {
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    var request: Request {
        return UserRequests.login(email: self.email, password: self.password)
    }
    
    func execute(in dispatcher: Dispatcher, completion: @escaping (User?, MessageError?) -> Void)  {
        dispatcher.execute(request: request) { (networkResponse) in
            switch networkResponse {
            case .data(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(singleUserResponse.self, from: data) {
                    completion(userResponse.data, nil)
                    return
                }
            case .error(let statusCode, let responseError): completion(nil, responseError)
            }
        }
    }
    
}

class SignUpTask: Operation {
    var email: String
    var password: String
    var username: String
    
    init(email: String, username: String, password: String) {
        self.email = email
        self.password = password
        self.username = username
    }
    
    var request: Request {
        return UserRequests.signUp(email: email, username: username, password: password)
    }
    
    func execute(in dispatcher: Dispatcher, completion: @escaping (User?, MessageError?) -> Void)  {
        dispatcher.execute(request: request) { (networkResponse) in
            switch networkResponse {
            case .data(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(singleUserResponse.self, from: data) {
                    completion(userResponse.data, nil)
                    return
                }
            case .error(let statusCode, let responseError): completion(nil, responseError)
            }
        }
    }
    
}

class UpdateUserInformationTask: Operation {
    var previousEmail: String
    var newEmail: String
    var previousUsername: String
    var newUsername: String
    
    var request: Request {
        return UserRequests.updateInfo(previousEmail: previousEmail, newEmail: newEmail, previousUsername: previousUsername, newUsername: newUsername)
    }
    
    init(previousEmail: String, newEmail: String, previousUsername: String, newUsername: String) {
        self.previousEmail = previousEmail
        self.newEmail = newEmail
        self.previousUsername = previousUsername
        self.newUsername = newUsername
    }
    
    func execute(in dispatcher: Dispatcher, completion: @escaping (User?, MessageError?) -> Void)  {
        dispatcher.execute(request: request) { (networkResponse) in
            switch networkResponse {
            case .data(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(singleUserResponse.self, from: data) {
                    completion(userResponse.data, nil)
                    return
                }
            case .error(let statusCode, let responseError): completion(nil, responseError)
            }
        }
    }
    
    
}
