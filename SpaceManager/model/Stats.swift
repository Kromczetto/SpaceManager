//
//  Stats.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 31/10/2024.
//

import Foundation

struct Stats: Identifiable, Codable {
    var id = UUID().uuidString
    let itemName: String
    let numberOfRead: Int
}
