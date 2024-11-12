//
//  StatsViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 31/10/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
class StatsViewModel: ObservableObject {
    @Published var stats: User?
    func readStats() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        let docRef = db.collection("users")
            .document(uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                do {
                    self.stats = try document.data(as: User.self)
                    print("current user: \(self.stats!.numberOfAddedItem) \(self.stats!.numberOfReadItem)")
                } catch {
                    print("Użytkownika")
                }
            } else {
                print("kolekcja nie istnije")
            }
        }
        
    }
    func setNumberOfAddedItems() {
        if let userStats = stats {
            var addAmount: Int = userStats.numberOfAddedItem
            addAmount += 1
            let itemRead: [[String: Int]] = userStats.itemReads
            let readAmount: Int = userStats.numberOfReadItem
            self.setItemStats(addAmount: addAmount, readAmount: readAmount, itemRead: itemRead)
        }
    }
    func setNumberOfReadItems() {
        print("miau")
    }
    func setReadItem() {
        
    }
    private func setItemStats(addAmount: Int, readAmount: Int, itemRead: [[String: Int]]) {
        let updatedUser = User(uid: stats!.uid, email: stats!.email,
                               permission: stats!.permission, itemReads: itemRead,
                               numberOfAddedItem: addAmount, numberOfReadItem: readAmount)
        print(updatedUser)
        DispatchQueue.main.async {
            let db = Firestore.firestore()
            db.collection("users")
                .document(self.stats!.uid)
                .setData(updatedUser.toDictionary())
        }
    }
}
