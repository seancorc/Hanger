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
    
    func execute(request: Request, completion: @escaping (Any?) -> Void)
    
}
/**
 Responsible for executing requests and storing information about the network enviroment
 */
class NetworkManager {
    let baseURL = "http://localhost:5000/api"
    
    static let shared = NetworkManager() //fix this no singleton
    
    /**
     - Parameter completion: Is given an optional JSON upon a successful request
     */
     func execute(request: Request, completion: @escaping (Any?) -> Void) {
            Alamofire.request("\(self.baseURL)\(request.path)", method: request.method, parameters: request.parameters, encoding: JSONEncoding.default, headers: [:]).validate().responseData { (response) in
                switch response.result {
                case .success(let data):
                    if let json = self.jsonFromResponseDate(data: data) {
                        print(json)
                        completion(json)
                    }
                case .failure(let error): print(error.localizedDescription)
                }
            }
        }
    
    
    private func jsonFromResponseDate(data: Data) -> Any? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return json
        }catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
}
