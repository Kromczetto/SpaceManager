//
//  Photo.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 16/07/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class Photo: Identifiable, Codable {
    var pid: String = ""
    var imageURL: String = ""
    
    func toDictionary() -> [String: Any] {
        return ["pid": pid, "imageURL": imageURL]
    }
}
