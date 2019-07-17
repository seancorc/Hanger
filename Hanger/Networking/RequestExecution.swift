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


class MessageError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

protocol Dispatcher {
    func execute(request: Request, completion: @escaping ((NetworkResponse) -> Void))
}

enum NetworkResponse {
    case data(_ data: Data)
    case error(_ statusCode: Int, _ error: MessageError)
    
    init(response: (data: Data?, statusCode: Int?)) {
        if let code = response.statusCode {
        switch code {
        case 200...299: if let data = response.data {self = .data(data)} else {self = .error(500, MessageError("Internal Error"))}
        case 400: self = .error(400, MessageError("Incorrect Email/Password Combo"))
        case 401: self = .error(401, MessageError("User With That Email Already Exists"))
        case 402: self = .error(402, MessageError("User With That Username Already Exists"))
        default: self = .error(500, MessageError("Internal Error"))
        }
        } else {self = .error(500, MessageError("Internal Error"))}
    }
}


/**
 Responsible for executing requests and storing information about the network enviroment
 */
class NetworkManager: Dispatcher {
    let baseURL = "http://localhost:5000/api"
    
    private static let sharedNetworkManager = NetworkManager()
    
    static func shared() -> NetworkManager {
        return sharedNetworkManager
    }
    
    
    /**
     - Parameter completion: Is given an optional JSON upon a successful request
     */
    func execute(request: Request, completion: @escaping ((NetworkResponse) -> Void))  {
        Alamofire.request("\(self.baseURL)\(request.path)", method: request.method, parameters: request.parameters, encoding: JSONEncoding.default, headers: request.headers).validate().responseData { (response) in
                switch response.result {
                case .success(let data):
                    if let json = self.jsonFromResponseData(data: data) {
                        print("JSON RESPONSE:\n \(json)")
                        let networkResponse = NetworkResponse(response: (data: response.data, statusCode: response.response?.statusCode))
                        completion(networkResponse)
                    } else {print("data is not in JSON format")}
                case .failure(let error):
                    if let err = error as? AFError {
                        let networkRespose = NetworkResponse(response: (data: nil, statusCode: err.responseCode))
                        completion(networkRespose)
                    } else {
                        completion(NetworkResponse(response: (data: nil, statusCode: 500)))
                    }
                }
            }
        }
    
    
    private func jsonFromResponseData(data: Data) -> Any? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return json
        }catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    
}
