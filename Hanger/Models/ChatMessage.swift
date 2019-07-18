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

struct Chat {
    var chatName: String!
    var lastMessage: String!
    var conversation: [[ChatMessage]]!

    init(chatName: String, lastMessage: String, conversation: [[ChatMessage]]) {
        self.chatName = chatName
        self.lastMessage = lastMessage
        self.conversation = conversation
    }
}

struct ChatMessage {
    var text: String?
    let isMyMessage: Bool
    let date: String
    let messageType: MessageType
    var photo: UIImage?
    
    
    private init(isMyMessage: Bool, date: String, messageType: MessageType) {
        self.isMyMessage = isMyMessage
        self.date = date
        self.messageType = messageType
    }
    
    
    init(text: String, isMyMessage: Bool, date: String) {
        self.init(isMyMessage: isMyMessage, date: date, messageType: .text)
        self.text = text
    }
    
    init(isMyMessage: Bool, date: String, photo: UIImage) {
        self.init(isMyMessage: isMyMessage, date: date, messageType: .photo)
        self.photo = photo
    }
    
}
