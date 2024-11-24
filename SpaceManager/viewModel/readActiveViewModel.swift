//
//  ReadActiveViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 01/07/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ReadActiveViewModel: ObservableObject {
    @Published var activeItem: ActiveItem?
    func fetchItem(with id: String) async {
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        let docRef = db.collection("users")
                        .document(userID)
                        .collection("activeItems")
                        .document(id)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                do {
                    self.activeItem = try document.data(as: ActiveItem.self)
                } catch {
                    print("Problem z odczytaniem przedmiotu")
                }
            } else {
                print("kolekcja nie istnije")
            }
        }
    }
}
