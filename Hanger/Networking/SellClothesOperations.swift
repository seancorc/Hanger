//
//  File.swift
//  Hanger
//
//  Created by Sean Corcoran on 8/9/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import Promise

fileprivate func createClothingPostFromData(data: Data) -> ClothingPostResponse? {
    return try? JSONDecoder().decode(ClothingPostResponse.self, from: data)
}

fileprivate func createErrorFromData(data: Data) -> NetworkErrorResponse? {
    return try? JSONDecoder().decode(NetworkErrorResponse.self, from: data)
}

fileprivate func createClothingPostArrayFromData(data: Data) -> ClothingPostsResponse? {
    return try? JSONDecoder().decode(ClothingPostsResponse.self, from: data)
}

class CreatePostTask: Operation {
    var clothingType: String
    var category: String
    var name: String
    var brand: String
    var price: Int
    var description: String?
    var imageURLs: [String]
    
    init(clothingType: String, category: String, name: String, brand: String, price: Int, description: String?, imageURLs: [String]) {
        self.clothingType = clothingType
        self.category = category
        self.name = name
        self.brand = brand
        self.price = price
        self.description = description
        self.imageURLs = imageURLs
    }
    
    var request: Request {
        return SellClothesRequests.createPost(clothingType: clothingType, category: category, name: name, brand: brand, price: price, description: description, imageURLs: imageURLs)
    }
    
    func execute(in dispatcher: Dispatcher) -> Promise<ClothingPost> {
        return Promise { fulfill, reject in
            dispatcher.execute(request: self.request).then({ (response) in
                switch response.responseCode {
                case 200...299: guard let clothingPostResponse = createClothingPostFromData(data: response.data) else {
                    print(response.data)
                    reject(MessageError("Internal Error: Unable To Decode JSON"))
                    return
                    }
                    fulfill(clothingPostResponse.data)
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

class GetNearbyPostsTask: Operation {
    var radius: Int?
    var type: String?
    var category: String?
    var minPrice: Int?
    var maxPrice: Int?
    
    
    init(radius: Int? = nil, type: String? = nil, category: String? = nil, minPrice: Int? = nil, maxPrice: Int? = nil) {
        self.radius = radius
        self.type = type
        self.category = category
        self.minPrice = minPrice
        self.maxPrice = maxPrice
    }
    
    var request: Request {
        return SellClothesRequests.getNearbyPosts(radius: radius)
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



