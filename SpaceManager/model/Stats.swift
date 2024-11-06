//
//  Stats.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 31/10/2024.
//

import Foundation

struct Stats: Codable {
    let uid: String
    let itemReads: [String: Int]
    let numberOfAddedItem: Int
    let numberOfReadItem: Int
    func toDictionary() -> [String: Any] {
        return ["uid": uid, 
                "itemReads": itemReads,
                "numberOfAddedItem": numberOfAddedItem, 
                "numberOfReadItem": numberOfReadItem
        ]
    }
    
}
