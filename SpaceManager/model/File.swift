//
//  File.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 10/10/2024.
//

import Foundation

struct User: Codable {
    let uid: String
    let email: String
    let permission: Permission
    func toDictionary() -> [String: Any] {
        return ["uid": uid, "email": email, "permission": permission.rawValue]
    }
    
}
