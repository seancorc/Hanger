//
//  NetworkError.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/24/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation

struct NetworkErrorResponse: Codable, Error {
    var error: String
}
