//
//  Api.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 10/09/2024.
//

import Foundation

struct Api: Codable {
    let id: String
    let machineName: String
    let parm1: String
    let parm2: String
    let parm3: String
    let parm4: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case machineName
        case parm1
        case parm2
        case parm3
        case parm4
    }
}

//  "_id": "673a69193ea4092c2261aa65",
//  "machineName": "Skossiarka",
//  "parm1": "121231231233",
//  "parm2": "2asdasdasd22",
//  "parm3": "3",
//  "parm4": "123",
//  "__v": 0
