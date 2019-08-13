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



class NetworkManager: Dispatcher {
    private var enviroment: Enviroment
    
    private static let sharedNetworkManager = NetworkManager(enviroment: Enviroment(name: "Testing", baseURL: "http://localhost:5000/api", headers: ["Content-Type": "application/json", "Accept": "application/json"]))

    static func shared() -> NetworkManager {
        return sharedNetworkManager
    }
    
    required init(enviroment: Enviroment) {
        self.enviroment = enviroment
    }
    
    func execute(request: Request) -> Promise<AFResponse> {
        return Promise<AFResponse>() { fulfill, reject in
            guard let urlRequest = try? self.prepareURLRequest(for: request) else {reject(MessageError("Bad URL")); return}
            print(urlRequest.url)
            Alamofire.request(urlRequest).responseData { (response) in
                guard let data = response.data else {
                    reject(MessageError("Internal Error: No Response Data"))
                    return
                }
                if let httpResponse = response.response {
                    fulfill(AFResponse(responseCode: httpResponse.statusCode, data: data))
                    return
                } else {
                    reject(MessageError("Internal Error: Can't Connect To Server"))
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

        
        switch request.parameters {
        case .none: urlRequest.httpBody = nil
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
