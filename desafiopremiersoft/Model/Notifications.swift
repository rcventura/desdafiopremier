//
//  Notifications.swift
//  desafiopremiersoft
//
//  Created by Rodrigo Ventura on 19/04/21.
//

import Foundation

struct Notification: Codable {
    var notifications: [NotificationElements]
}


struct NotificationElements: Codable {
    var id: String
    var isRead: Bool
    var content: String
}
