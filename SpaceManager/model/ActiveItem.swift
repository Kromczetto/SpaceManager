//
//  ActiveItem.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 01/07/2024.
//

import Foundation

struct ActiveItem: Codable, Identifiable{
    let id: String
    let numberOfSpins: Int
    let electricityConsumpsion: Int
    let workingTime: Int
    
}
