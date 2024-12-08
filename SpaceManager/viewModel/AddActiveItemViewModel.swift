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
    func updateActiveItem(id: String, item: ActiveItem?, parm1: String, parm2: String, parm3: String, parm4: String) {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        guard let item = item else {
            return
        }
        let newActiveItem = ActiveItem(id: item.id, connection: item.connection,
                                       parm1: parm1,
                                       parm2: parm2,
                                       parm3: parm3,
                                       parm4: parm4)
        let db = Firestore.firestore()
        db.collection("users")
            .document(userID)
            .collection("activeItems")
            .document(id)
            .setData(["id": newActiveItem.id,
                      "connection": newActiveItem.connection,
                      "parm1": newActiveItem.parm1,
                      "parm2": newActiveItem.parm2,
                      "parm3": newActiveItem.parm3,
                      "parm4": newActiveItem.parm4
            ]){ error in
                if let error = error {
                   print("Error: \(error.localizedDescription)")
               } else {
                   print("Successfully updated active item")
               }
            }
    }
    func addNewActiveItem(itemID: String, apiURL: String, did: String) {
        if apiURL.isEmpty {
            print("apiURL can not be empty")
            return
        }
    
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        let newActiveItem = ActiveItem(id: did, connection: [itemID: apiURL], parm1: "Paramater 1", parm2: "Parametr 2", parm3: "Parametr 3", parm4: "Parametr 4")
        let db = Firestore.firestore()
        db.collection("users")
            .document(userID)
            .collection("activeItems")
            .document(itemID)
            .setData(["id": newActiveItem.id,
                      "connection": newActiveItem.connection,
                      "parm1": newActiveItem.parm1,
                      "parm2": newActiveItem.parm2,
                      "parm3": newActiveItem.parm3,
                      "parm4": newActiveItem.parm4
            ]){ error in
                if let error = error {
                   print("Error: \(error.localizedDescription)")
               } else {
                   print("Successfully added new active item")
               }
            }
    }
}
