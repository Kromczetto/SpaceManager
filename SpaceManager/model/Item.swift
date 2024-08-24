//
//  Item.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 26/06/2024.
//

import Foundation

struct Item: Codable, Identifiable{
    let id: String
    let name: String
    let amount: String
    let nameOfAdder: String
    let commentsToItem: String
    let productWeight: String
    let addDate: Date
    let properties: [[String: String]]
}
