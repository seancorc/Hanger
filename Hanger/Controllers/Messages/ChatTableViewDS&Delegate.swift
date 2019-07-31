//
//  ChatTableViewDS&Delegate.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/30/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import UIKit

class ChatTableViewDataSourceAndDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    var messages = [ChatMessage]()
    var cellHeights: [IndexPath: CGFloat] = [:]
    
    init(messages: [ChatMessage]) {
        super.init()
        self.messages = messages
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    //Used to obtain accurate estimated row height ~ without this scrollToRowAt looks really jumpy and glitchy (https://stackoverflow.com/questions/28244475/reloaddata-of-uitableview-with-dynamic-cell-heights-causes-jumpy-scrolling)
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath] ?? 150
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50 * Global.ScaleFactor
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Global.CellID, for: indexPath) as! ChatTableViewCell
        let chatMessage = messages[indexPath.row]
        switch chatMessage.messageType {
        case .photo: cell.configureCell(chatMessage: chatMessage)
        case .text: cell.configureCell(chatMessage: chatMessage)
        }
        return cell
    }
    
}
