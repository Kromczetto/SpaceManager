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
    @Published var isDeleted: Bool = false
    
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
    func saveNewData(idOfItem: String, nameOfItem: String, amountOfItem: String,
                     weigthOfItem: String, commentsToItem: String){
        guard let userID = Auth.auth().currentUser?.uid else{
            return
        }
        guard let userName = Auth.auth().currentUser?.email else{
            return
        }
        let data = Item(id:idOfItem,
                           name: nameOfItem,
                           amount: amountOfItem,
                           nameOfAdder: userName,
                           commentsToItem: commentsToItem,
                           productWeight: weigthOfItem,
                           addDate: Date(),
                        properties: [["key":"value"]] //remove
        )
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
                      "addDate": data.addDate,
                      "properties": [["key":"valie"]]
            ])
    }
    func delete(id: String){
        let db = Firestore.firestore()
       
        guard let userID = Auth.auth().currentUser?.uid else{
            return
        }
        db.collection("users")
                        .document(userID)
                        .collection("items")
                        .document(id)
                        .delete()
        isDeleted = true
    }
}
