//
//  ChatMessage.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/3/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import UIKit

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
    
    init(text: String, isMyMessage: Bool) {
        self.text = text
        self.isMyMessage = isMyMessage
    }
    
}
