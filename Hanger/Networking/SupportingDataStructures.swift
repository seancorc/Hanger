//
//  SupportingDataStructures.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/25/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import Promise

//MARK : REQUEST CREATION

enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

protocol Request {
    var path: String { get }
    
    var method: HTTPMethod { get }
    
    var parameters: RequestParameters { get }
    
    var headers: [String: String] { get }
}


enum RequestParameters {
    case body(_ : [String:String])
    case url(_ : [String:String])
    case none
}



//MARK : REQUEST EXECUTION

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

//MARK: REQUEST OPERATION

protocol Operation {
    
    associatedtype OutputType
    
    var request: Request { get }
    
    func execute(in dispatcher: Dispatcher) -> Promise<OutputType>
    
}

