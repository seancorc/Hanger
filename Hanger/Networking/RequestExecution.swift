//
//  File.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/7/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import Alamofire
import Promise

class MessageError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

struct AFResponse {
    let responseCode: Int
    let data: Data
}

struct Enviroment {
    
    var name: String
    
    var baseURL: String
    
    var headers: [String:String]
    
    init(name: String, baseURL: String, headers: [String : String]) {
        self.name = name
        self.baseURL = baseURL
        self.headers = headers
    }
    
    //Any other env variables and setup...
}

protocol Dispatcher {
    init(enviroment: Enviroment)
    
    
    func execute(request: Request) -> Promise<AFResponse>
    
}

class NetworkManager: Dispatcher {
    private var enviroment: Enviroment
    
    private static let sharedNetworkManager = NetworkManager(enviroment: Enviroment(name: "Testing", baseURL: "http://localhost:5000/api", headers: [:]))
    
    static func shared() -> NetworkManager {
        return sharedNetworkManager
    }
    
    required init(enviroment: Enviroment) {
        self.enviroment = enviroment
    }
    
    func execute(request: Request) -> Promise<AFResponse> {
        return Promise<AFResponse>() { fulfill, reject in
            guard let urlRequest = try? self.prepareURLRequest(for: request) else {reject(MessageError("Bad URL")); return}
            Alamofire.request(urlRequest).responseData { (response) in
                guard let data = response.data else {
                    reject(MessageError("Internal Error: Can't Connect To Server"))
                    return
                }
                if let httpResponse = response.response {
                    fulfill(AFResponse(responseCode: httpResponse.statusCode, data: data))
                    return
                } else {
                    reject(MessageError("Internal Error: No httpResponse"))
                }
            }
        }
    }
    
    
    private func jsonFromResponseData(data: Data) -> Any? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return json
        } catch {
            return nil
        }
    }
    
    private func prepareURLRequest(for request: Request) throws -> URLRequest {
        let fullURL = "\(enviroment.baseURL)\(request.path)"
        guard let url = URL(string: fullURL) else {throw MessageError("Bad URL")}
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        switch request.parameters {
        case .none: break
        case .body(let params):
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            
        case .url(let params):
            let query_params = params.map({ return URLQueryItem(name: $0.key, value: $0.value)})
            guard var components = URLComponents(string: fullURL) else {
                throw MessageError("Bad URL")
            }
            components.queryItems = query_params
            urlRequest.url = components.url
        }
        
        // Add headers from enviornment and request
        enviroment.headers.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)}
        request.headers.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)}
        
        urlRequest.httpMethod = request.method.rawValue
        
        return urlRequest
    }
    
}
