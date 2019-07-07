//
//  ChatMessage.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/3/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import UIKit

enum MessageType {
    case text
    case photo
}

struct ChatMessage {
    let text: String
    let isMyMessage: Bool
    let date: String
    let messageType: MessageType
    var photo: UIImage?
    
    init(text: String, isMyMessage: Bool, date: String, messageType: MessageType, photo: UIImage? = nil) {
        self.text = text
        self.isMyMessage = isMyMessage
        self.date = date
        self.messageType = messageType
        self.photo = photo
    }
}
