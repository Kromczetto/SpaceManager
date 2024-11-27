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
    @Published var isActiveItem: Bool = false

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
                   // DispatchQueue.main.async {
                        self.isActiveItem = true
                        self.activeItem = try document.data(as: ActiveItem.self)
                  //  }
                } catch {
                    self.isActiveItem = false
                    print("Problem z odczytaniem przedmiotu")
                }
            } else {
                self.isActiveItem = false
                print("kolekcja nie istnije")
            }
        }
    }
}
