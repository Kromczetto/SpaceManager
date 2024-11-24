//
//  User.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 03/05/2024.
//

import Foundation

enum Permission: String, Codable {
    case Adder
    case Reader
    case Full
    case Admin
    case Error
}
struct User: Codable {
    let uid: String
    let email: String
    let permission: Permission
//    let itemReads: [[String: Int]]
    var itemReads: [String: Int]
    let numberOfAddedItem: Int
    let numberOfReadItem: Int
    func toDictionary() -> [String: Any] {
        return ["uid": uid,
                "email": email,
                "permission": permission.rawValue,
                "itemReads": itemReads,
                "numberOfAddedItem": numberOfAddedItem,
                "numberOfReadItem": numberOfReadItem
        ]
    }
    
}
