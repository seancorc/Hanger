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

protocol Dispatcher {
    
    func execute(request: Request, completion: @escaping (Data) -> Void)
    
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
     func execute(request: Request, completion: @escaping (Data) -> Void) {
        Alamofire.request("\(self.baseURL)\(request.path)", method: request.method, parameters: request.parameters, encoding: JSONEncoding.default, headers: request.headers).validate().responseData { (response) in
                switch response.result {
                case .success(let data):
                    if let json = self.jsonFromResponseData(data: data) {
                        print(json)
                        completion(data)
                    } else {print("data is not in JSON format")}
                case .failure(let error): print(error.localizedDescription)
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
