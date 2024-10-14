//
//  Favourite.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 10/10/2024.
//

import Foundation

struct Favourite: Codable {
    let fid: String
    let favourites: String
    func toDictionary() -> [String: Any] {
        return ["fid": fid, "favourites": favourites]
    }
    
}
