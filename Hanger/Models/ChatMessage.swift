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

struct Conversation {
    var convoName: String!
    var lastMessage: String!
    var messages: [ChatMessage]!
    var timeStamp = Int(Date().timeIntervalSince1970)
    var userIDs = [String]()

    init(convoName: String, lastMessage: String, messages: [ChatMessage]) {
        self.convoName = convoName
        self.lastMessage = lastMessage
        self.messages = messages
    }
}

struct ChatMessage {
    var text: String?
    let isMyMessage: Bool
    let messageType: MessageType
    var photo: UIImage?
    
    
    private init(isMyMessage: Bool, messageType: MessageType) {
        self.isMyMessage = isMyMessage
        self.messageType = messageType
    }
    
    init(text: String, isMyMessage: Bool) {
        self.init(isMyMessage: isMyMessage, messageType: .text)
        self.text = text
    }
    
    init(isMyMessage: Bool, photo: UIImage) {
        self.init(isMyMessage: isMyMessage, messageType: .photo)
        self.photo = photo
    }
    
}
