//
//  ReadItemViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 28/06/2024.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth

class ReadItemViewModel: ObservableObject {
    @Published var item: Item?
    
    func fetchItem(with id: String) {
        let db = Firestore.firestore()
       
        guard let userID = Auth.auth().currentUser?.uid else{
            return
        }
        let docRef = db.collection("users")
                        .document(userID)
                        .collection("items")
                        .document(id)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                do {
                    self.item = try document.data(as: Item.self)
                } catch {
                    print("Problem z odczytaniem przedmiotu")
                }
            } else {
                print("kolekcja nie istnije")
            }
        }
    }
    func prepairDate(input: Date)-> String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pl_PL")
        formatter.dateFormat = "d MMMM yyyy"
        let formattedDate = formatter.string(from: input)
        return formattedDate
    }
    func saveNewData(){
        let data = Item(id:"845A36A8-AC18-43BE-BD85-DC40CF5DDA20",
                           name: "sadas",
                           amount: "a",
                           nameOfAdder: "a",
                           commentsToItem: "comments",
                           productWeight: "weight",
                           addDate: Date()
        )
        guard let userID = Auth.auth().currentUser?.uid else{
            return
        }
        let db = Firestore.firestore()
        db.collection("users")
            .document(userID)
            .collection("items")
            .document(data.id)
            .setData(["id": data.id,
                      "name": data.name,
                      "amount": data.amount,
                      "commentsToItem": data.commentsToItem,
                      "nameOfAdder": data.nameOfAdder,
                      "productWeight": data.productWeight,
                      "addDate": data.addDate
            ])
    }
}
