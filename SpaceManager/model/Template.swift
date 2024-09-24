//
//  Template.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 13/09/2024.
//

import Foundation

struct Template: Codable {
    let tid: String
    let name: String
    let propertiesKey: [String]
    func toDictionary() -> [String: Any] {
        return ["tid": tid, "name": name, "propertiesKey": propertiesKey]
    }
}
