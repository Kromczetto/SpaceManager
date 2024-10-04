//
//  MainViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 03/05/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AddNewItemViewModel: ObservableObject{
    @Published var itemName: String = ""
    @Published var numberOfItems: String = ""
    @Published var weight: String = ""
    @Published var comments: String = ""
    @Published var itemID: String = ""
    
    @Published var isSuccess: Bool = false
    @Published var isFail: Bool = false
    @Published var message: String = ""
    
    var itemNameHolder: String = ""
    
    private var tempProperty: [String: String] = [:]
    
    @Published var properties: [[String: String]] = []
    @Published var propertyKey: [String] = [""]
    @Published var propertyValue: [String] = [""]
    @Published var listIndex: Int = 0
    
    
    func validItemField()-> Bool {
        var itemNameWithoutWhiteCharacters: String {
            itemName.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        var amountWithoutWhiteCharacters: String {
            numberOfItems.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        var weightWithoutWhiteCharacters: String {
            weight.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        var commentsWithoutWhiteCharacters: String {
            comments.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if(itemNameWithoutWhiteCharacters.isEmpty ||
           amountWithoutWhiteCharacters.isEmpty ||
           weightWithoutWhiteCharacters.isEmpty ||
           commentsWithoutWhiteCharacters.isEmpty){
            message = "Żadne pole nie może być puste"
            return false
        }
        let amountIsDigits = amountWithoutWhiteCharacters.allSatisfy { $0.isNumber }
        let weigthIsDigits = weightWithoutWhiteCharacters.allSatisfy { $0.isNumber }
        
        if(!amountIsDigits || !weigthIsDigits) {
            message = "Liczba i waga muszą być dodatnimi liczbami"
            return false
        }
        
        return true
    }
    
    func addItemToDatabase() {
        if(!validItemField()) {
            self.isSuccess = false
            self.isFail = true
            return
        }
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        guard let userName = Auth.auth().currentUser?.email else {
            return
        }

        let newItem = Item(id:itemID,
                           name: itemName,
                           amount: numberOfItems,
                           nameOfAdder: userName,
                           commentsToItem: comments,
                           productWeight: weight,
                           addDate: Date(),
                           properties: properties
        )
    
        let db = Firestore.firestore()
        db.collection("users")
            .document(userID)
            .collection("items")
            .document(itemID)
            .setData(["id": newItem.id, 
                      "name": newItem.name,
                      "amount": newItem.amount,
                      "commentsToItem": newItem.commentsToItem,
                      "nameOfAdder": newItem.nameOfAdder,
                      "productWeight": newItem.productWeight,
                      "addDate": newItem.addDate,
                      "properties": newItem.properties
            ]){ error in
                if let error = error {
                    self.isSuccess = false
                    self.isFail = true
                } else {
                    self.itemNameHolder = self.itemName
                    self.isSuccess = true
                    self.isFail = false
                    self.itemName = ""
                    self.numberOfItems = ""
                    self.weight = ""
                    self.comments = ""
                }
            }
    }
    func createProperty() {
        if (listIndex == 0) {
            tempProperty[propertyKey[self.listIndex]] = propertyValue[self.listIndex]
            properties.append(tempProperty)
            tempProperty.removeAll()
            propertyKey.append("")
            propertyValue.append("")
            self.listIndex = listIndex + 1
        } else {
            print(listIndex)
            tempProperty[propertyKey[self.listIndex - 1]] = propertyValue[self.listIndex - 1]
            properties.append(tempProperty)
            tempProperty.removeAll()
            propertyKey.append("")
            propertyValue.append("")
            self.listIndex = listIndex + 1
        }
    }
    func removeItems(at offsets: IndexSet) {
        propertyKey.remove(atOffsets: offsets)
        propertyValue.remove(atOffsets: offsets)
        properties.remove(atOffsets: offsets)
        self.listIndex = listIndex - 1
    }
    func canAddNewProperty() -> Bool {
        if (self.listIndex == 0) {
            return false
        }
        if (propertyKey[self.listIndex - 1].isEmpty || propertyValue[self.listIndex - 1].isEmpty) {
            return true
        }
        return false
    }
    func splitArray() {
        if (properties.count > 0 || !properties.isEmpty) {
            propertyKey.removeFirst()
            propertyValue.removeFirst()
            properties.removeFirst()
        }
    }
    func fillArray(prop: [String]) {
        properties.removeAll()
        propertyKey.removeAll()
        propertyValue.removeAll()
        for p in prop {
            propertyKey.append(p)
            propertyValue.append("")
            tempProperty[propertyKey[0]] = p
            properties.append(tempProperty)
            tempProperty.removeAll()
        }
        splitArray()
    }
}
