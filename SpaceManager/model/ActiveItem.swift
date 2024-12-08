//
//  ActiveItem.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 01/07/2024.
//

import Foundation

struct ActiveItem: Codable, Identifiable {
    let id: String
    let connection: [String: String]
    let parm1: String
    let parm2: String
    let parm3: String
    let parm4: String
}
