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
    @Published var tempKeys: [String] = []
    @Published var tempValues: [String] = []
    private var tempProperties: [[String: String]] = []
    private var tempDictionary: [String: String] = [:]
    
    func fetchItem(with id: String) {
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
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
    func prepairDate(input: Date)-> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pl_PL")
        formatter.dateFormat = "d MMMM yyyy"
        let formattedDate = formatter.string(from: input)
        return formattedDate
    }
    func saveNewData(idOfItem: String, nameOfItem: String, amountOfItem: String,
                     weigthOfItem: String, commentsToItem: String) {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        guard let userName = Auth.auth().currentUser?.email else {
            return
        }
        createDictionary()
        let data = Item(id:idOfItem,
                        name: nameOfItem,
                        amount: amountOfItem,
                        nameOfAdder: userName,
                        commentsToItem: commentsToItem,
                        productWeight: weigthOfItem,
                        addDate: Date(),
                        properties: self.tempProperties
        )
        DispatchQueue.main.async {
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
                          "properties": data.properties
                ])
        }
    }
    func delete(id: String) {
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        db.collection("users")
                        .document(userID)
                        .collection("items")
                        .document(id)
                        .delete()
        isDeleted = true
    }
    func splitProperties() {
        if let item = item {
            tempKeys.removeAll()
            tempValues.removeAll()
            for index in item.properties {
                for (key, value) in index {
                    var formatedKey: String = key
                    tempKeys.append(key)
                    tempValues.append(value)
                }
            }
            self.tempProperties.removeAll()
        }
    }
    func createDictionary() {
        tempProperties.removeAll()
        tempDictionary.removeAll()
        for i in 0..<tempKeys.count {
            tempDictionary[tempKeys[i]] = tempValues[i]
            tempProperties.append(tempDictionary)
            tempDictionary.removeAll()
        }
    }
}
