//
//  PerformOperations.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/10/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import Promise


fileprivate func createUserFromData(data: Data) -> UserResponse? {
    return try? JSONDecoder().decode(UserResponse.self, from: data)
}

fileprivate func createErrorFromData(data: Data) -> NetworkErrorResponse? {
    return try? JSONDecoder().decode(NetworkErrorResponse.self, from: data)
}

fileprivate func createClothingPostArrayFromData(data: Data) -> ClothingPostsResponse? {
    return try? JSONDecoder().decode(ClothingPostsResponse.self, from: data)
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
                    guard let userResponse = createUserFromData(data: response.data) else {
                        reject(MessageError("Internal Error: Unable To Decode JSON"))
                        return
                    }
                    UserDefaults.standard.set(userResponse.accessToken, forKey: UserDefaultKeys.token) //Change to keychain at some point
                    fulfill(userResponse.data)
                default:
                    guard let error = createErrorFromData(data: response.data) else {
                        reject(MessageError("Internal Error: Response Code-\(response.responseCode)"))
                        return
                    }
                    reject(MessageError(error.error))
                }
            }).catch({ (error) in reject(error)})
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
    
    func execute(in dispatcher: Dispatcher) -> Promise<User> {
        return Promise { fulfill, reject in
            dispatcher.execute(request: self.request).then({ (response) in
                switch response.responseCode {
                case 200...299:
                    print(try! JSONSerialization.jsonObject(with: response.data, options: .allowFragments))
                    guard let userResponse = createUserFromData(data: response.data) else {
                        reject(MessageError("Internal Error: Unable To Decode JSON"))
                        return
                    }
                    UserDefaults.standard.set(userResponse.accessToken, forKey: UserDefaultKeys.token) //Change to keychain at some point
                    fulfill(userResponse.data)
                default:
                    guard let error = createErrorFromData(data: response.data) else {
                        reject(MessageError("Internal Error: Response Code-\(response.responseCode)"))
                        return
                    }
                    reject(MessageError(error.error))
                }
            }).catch({ (error) in reject(error)})
        }
    }
    
    
}

class UpdateUserInformationTask: Operation {
    var userID: Int
    var newEmail: String
    var newUsername: String
    
    var request: Request {
        return UserRequests.updateInfo(newEmail: newEmail, newUsername: newUsername)
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
                    guard let userResponse = createUserFromData(data: response.data) else {
                        reject(MessageError("Internal Error: Unable To Decode JSON"))
                        return
                    }
                    fulfill(userResponse.data)
                default:
                    guard let error = createErrorFromData(data: response.data) else {
                        reject(MessageError("Internal Error: Response Code-\(response.responseCode)"))
                        return
                    }
                    reject(MessageError(error.error))
                }
            }).catch({ (error) in reject(error)})
        }
    }

}

class UpdatePasswordTask: Operation {
    var userID: Int
    var currentPassword: String
    var newPassword: String
    
    var request: Request {
        return UserRequests.updatePassword(currentPassword: currentPassword, newPassword: newPassword)
    }
    
    init(userID: Int, currentPassword: String, newPassword: String) {
        self.userID = userID
        self.currentPassword = currentPassword
        self.newPassword = newPassword
    }
    
    func execute(in dispatcher: Dispatcher) -> Promise<()> { //Fulfills with void
        return Promise { fulfill, reject in
            dispatcher.execute(request: self.request).then({ (response) in
                switch response.responseCode {
                case 200...299:
                    fulfill(())
                default:
                    guard let error = createErrorFromData(data: response.data) else {
                        reject(MessageError("Internal Error: Response Code-\(response.responseCode)"))
                        return
                    }
                    reject(MessageError(error.error))
                }
            }).catch({ (error) in reject(error)})
        }
    }
    
}

class ModifyProfilePictureTask: Operation {
    var url: String
    
    var request: Request {
        return UserRequests.modifyProfilePicture(url: url)
    }
    
    init(url: String) {
        self.url = url
    }
    
    func execute(in dispatcher: Dispatcher) -> Promise<()> {
        return Promise { fulfill, reject in
            dispatcher.execute(request: self.request).then({ (response) in
                switch response.responseCode {
                case 200...299:
                    fulfill(())
                default:
                    guard let error = createErrorFromData(data: response.data) else {
                        reject(MessageError("Internal Error: Response Code-\(response.responseCode)"))
                        return
                    }
                    reject(MessageError(error.error))
                }
            }).catch({ (error) in reject(error)})
        }
    }
}

class GetUserPostsTask: Operation {
    
    var request: Request {
        return UserRequests.getPostsForUser
    }
    
    func execute(in dispatcher: Dispatcher) -> Promise<[ClothingPost]> {
        return Promise { fulfill, reject in
            dispatcher.execute(request: self.request).then({ (response) in
                switch response.responseCode {
                case 200...299: guard let clothingPostsResponse = createClothingPostArrayFromData(data: response.data) else {
                    reject(MessageError("Internal Error: Unable To Decode JSON"))
                    return
                }
                fulfill(clothingPostsResponse.data)
                default:
                    guard let error = createErrorFromData(data: response.data) else {
                        reject(MessageError("Internal Error: Response Code-\(response.responseCode)"))
                        return
                    }
                    reject(MessageError(error.error))
                }
            }).catch({ (error) in reject(error)})
        }
        
    }
}

