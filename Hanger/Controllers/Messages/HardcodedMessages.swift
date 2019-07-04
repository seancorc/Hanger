//
//  HardcodedMessages.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/3/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation

class HardCodedChatMessages {
    
    static let conversationArray = [HardCodedChatMessages.WestCoastDistrict, HardCodedChatMessages.JobPostings, HardCodedChatMessages.LilyWilson]
    
    
    
    static let WestCoastDistrict = [ [ //1D array represents different dates, 2D represents messages
        ChatMessage(text: "Hello everyone, welcome to the West Coast ambassador group chat! \n\nEarly heads up that we will be having an ambassador meetup on Sunday 6/23/19, super excited to see you all there! 😃", isMyMessage: false, date: Date(timeIntervalSinceNow: -3000000.0).shortDate,  messageType: .text),
        ChatMessage(text: "Wow this is so cool!", isMyMessage: true, date: Date(timeIntervalSinceNow: -3000000.0).shortDate,  messageType: .text),
        ChatMessage(text: "Carbon38 is freaking lit!🔥", isMyMessage: false, date: Date(timeIntervalSinceNow: -3000000.0).shortDate,  messageType: .text),
        ChatMessage(text: "True!!", isMyMessage: false, date: Date(timeIntervalSinceNow: -3000000.0).shortDate,  messageType: .text), ChatMessage(text: "So hyped for the meetup!", isMyMessage: false, date: Date(timeIntervalSinceNow: -3000000.0).shortDate,  messageType: .text)],
                                     [ChatMessage(text: "Hey guys! Does anyone know a good yoga studio in the Culver City area? \nThanks!", isMyMessage: false, date: Date(timeIntervalSinceNow: -1000000.0).shortDate,  messageType: .text),
                                      ChatMessage(text: "My favorite studio is Red Diamond Yoga. Luckily Maria is an instructor there so you can find some info on the studio in the #Team38 Studios section", isMyMessage: true, date: Date(timeIntervalSinceNow: -1000000.0).shortDate,  messageType: .text),
                                      ChatMessage(text: "Ya defintley come through! First session is on me 😊🧘‍♀️", isMyMessage: false, date: Date(timeIntervalSinceNow: -1000000.0).shortDate,  messageType: .text)], [ChatMessage(text: "Anyone in the Santa Monica area want to get brunch today?", isMyMessage: true, date: Date().shortDate,  messageType: .text), ChatMessage(text: "I'm down!", isMyMessage: false, date: Date().shortDate,  messageType: .text), ChatMessage(text: "Great! I'll DM you", isMyMessage: true, date: Date().shortDate,  messageType: .text)]]
    
    static let JobPostings = [ [ //1D array represents different dates, 2D represents messages
        ChatMessage(text: "Hello West Coast ambassadors! This is a space for you guys to share work opportunities and business related information with one another.", isMyMessage: false, date: Date(timeIntervalSinceNow: -3000000.0).shortDate,  messageType: .text),
        ChatMessage(text: "This is definitely going to be super helpful", isMyMessage: false, date: Date(timeIntervalSinceNow: -3000000.0).shortDate,  messageType: .text),
        ChatMessage(text: "Carbon38 is absolutely killing the game!", isMyMessage: false, date: Date(timeIntervalSinceNow: -3000000.0).shortDate,  messageType: .text)],
                               [ChatMessage(text: "Job opportunity in Venice - \nPosition: yoga instructor \nHours: Flexible but with a minimum of 20 a week \nPay: $40 an hour \n\nHMU ASAP if you're interested", isMyMessage: false, date: Date(timeIntervalSinceNow: -400000.0).shortDate,  messageType: .text),
                                ChatMessage(text: "Just DM'd you!", isMyMessage: true, date: Date(timeIntervalSinceNow: -400000.0).shortDate,  messageType: .text)], [ChatMessage(text: "Job opportunity in Huntington - \nPosition: Personal Trainer \nHours: 15/week \nPay: $35 an hour", isMyMessage: false, date: Date().shortDate,  messageType: .text)]]
    
    static let LilyWilson = [ [ //1D array represents different dates, 2D represents messages
        ChatMessage(text: "Hey Lily, can you tell me a little more about the yoga instructor positon?", isMyMessage: true, date: Date(timeIntervalSinceNow: -86400 * 3.0).shortDate,  messageType: .text),
        ChatMessage(text: "Ya! So the opportunity is at a yoga studio which I regularly attend and everyone there is super cool! I am pretty good friends with the other instructors there and I know how qualified you are so if I can def put in a good word for you.", isMyMessage: false, date: Date(timeIntervalSinceNow: -86400 * 3.0).shortDate,  messageType: .text),
        ChatMessage(text: "Ya the studio and people sound great, I am going to apply right now. Thank you so much for letting me know about this opportunity!🙏", isMyMessage: true, date: Date(timeIntervalSinceNow: -86400 * 3.0).shortDate,  messageType: .text),ChatMessage(text: "No problem!👍", isMyMessage: false, date: Date(timeIntervalSinceNow: -86400 * 3.0).shortDate,  messageType: .text)]]
    

}
