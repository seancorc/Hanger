//
//  PerformOperations.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/10/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import Promise

protocol Operation {
    
    associatedtype OutputType
    
    var request: Request { get }
    
    func execute(in dispatcher: Dispatcher) -> Promise<OutputType>
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
    
    func execute(in dispatcher: Dispatcher) -> Promise<User> {
        return Promise { fulfill, reject in
            dispatcher.execute(request: self.request).then({ (response) in
                    switch response.responseCode {
                    case 200...299:
                        guard let userResponse = self.createUserFromData(data: response.data) else {
                            reject(MessageError("Internal Error: Unable To Decode JSON"))
                            return
                        }
                        fulfill(userResponse.data)
                    default:
                        guard let error = self.createErrorFromData(data: response.data) else {
                            reject(MessageError("Internal Error: Unable To Decode JSON"))
                            return
                        }
                        reject(MessageError(error.error))
                    }
                }).catch({ (error) in reject(error)})
        }
    }
    
    
    private func createUserFromData(data: Data) -> UserResponse? {
        return try? JSONDecoder().decode(UserResponse.self, from: data)
    }
    
    private func createErrorFromData(data: Data) -> NetworkErrorResponse? {
        return try? JSONDecoder().decode(NetworkErrorResponse.self, from: data)
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
    
    func execute(in dispatcher: Dispatcher) -> Promise<User> {
        return Promise { fulfill, reject in
            dispatcher.execute(request: self.request).then({ (response) in
                switch response.responseCode {
                case 200...299:
                    guard let userResponse = self.createUserFromData(data: response.data) else {
                        reject(MessageError("Internal Error: Unable To Decode JSON"))
                        return
                    }
                    fulfill(userResponse.data)
                default:
                    guard let error = self.createErrorFromData(data: response.data) else {
                        reject(MessageError("Internal Error: Unable To Decode JSON"))
                        return
                    }
                    reject(MessageError(error.error))
                }
            }).catch({ (error) in reject(error)})
        }
    }
    
    
    private func createUserFromData(data: Data) -> UserResponse? {
        return try? JSONDecoder().decode(UserResponse.self, from: data)
    }
    
    private func createErrorFromData(data: Data) -> NetworkErrorResponse? {
        return try? JSONDecoder().decode(NetworkErrorResponse.self, from: data)
    }
    
    
}

class UpdateUserInformationTask: Operation {
    var userID: Int
    var newEmail: String
    var newUsername: String
    
    var request: Request {
        return UserRequests.updateInfo(userID: userID, newEmail: newEmail, newUsername: newUsername)
    }
    
    init(userID: Int, newEmail: String, newUsername: String) {
        self.userID = userID
        self.newEmail = newEmail
        self.newUsername = newUsername
    }
    
    func execute(in dispatcher: Dispatcher) -> Promise<User> {
        return Promise { fulfill, reject in
            dispatcher.execute(request: self.request).then({ (response) in
                switch response.responseCode {
                case 200...299:
                    guard let userResponse = self.createUserFromData(data: response.data) else {
                        reject(MessageError("Internal Error: Unable To Decode JSON"))
                        return
                    }
                    fulfill(userResponse.data)
                default:
                    guard let error = self.createErrorFromData(data: response.data) else {
                        reject(MessageError("Status Code Unacceptable - \(response.responseCode) - & Internal Error: Unable To Decode JSON"))
                        return
                    }
                    reject(MessageError(error.error))
                }
            }).catch({ (error) in reject(error)})
        }
    }
    
    
    private func createUserFromData(data: Data) -> UserResponse? {
        return try? JSONDecoder().decode(UserResponse.self, from: data)
    }
    
    private func createErrorFromData(data: Data) -> NetworkErrorResponse? {
        return try? JSONDecoder().decode(NetworkErrorResponse.self, from: data)
    }
    
    
    
}
