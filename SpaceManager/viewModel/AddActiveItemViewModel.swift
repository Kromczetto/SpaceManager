//
//  AddActiveItemViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 24/11/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
class AddActiveItemViewModel: ObservableObject {
    func addNewActiveItem(itemID: String, apiURL: String) {
        if apiURL.isEmpty {
            print("apiURL can not be empty")
            return
        }
    
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        let newActiveItem = ActiveItem(id: UUID().uuidString, connection: [itemID: apiURL])
        let db = Firestore.firestore()
        db.collection("users")
            .document(userID)
            .collection("activeItems")
            .document(itemID)
            .setData(["id": newActiveItem.id,
                      "connection": newActiveItem.connection
            ]){ error in
                if let error = error {
                   print("Error: \(error.localizedDescription)")
               } else {
                   print("Successfully added new active item")
               }
            }
    }
}
