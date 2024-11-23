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
    @Published var itemStat: [Stats] = []
    private var items: [Item] = []
    init() {
        getItems()
    }
    func getItems() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        items.removeAll()
        let docRef = db.collection("users")
            .document(uid)
            .collection("items")
            .getDocuments { (snap, err) in
                snap?.documents.forEach({doc in
                    let dictionary = doc.data()
                    if !dictionary.isEmpty {
                        let item: Item = Item(id: dictionary["id"] as! String,
                                              name: dictionary["name"] as! String,
                                              amount: dictionary["amount"] as! String,
                                              nameOfAdder: dictionary["nameOfAdder"] as! String,
                                              commentsToItem: dictionary["commentsToItem"] as! String,
                                              productWeight: dictionary["productWeight"] as! String,
                                              addDate: Date(),
                                              properties: []
                        )
                        self.items.append(item)
                    } else {
                        return
                    }
                })
            }
    }
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
                    print("current stats: \(self.stats!.numberOfAddedItem) \(self.stats!.numberOfReadItem)")
                } catch {
                    print(error.localizedDescription)
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
            let readAmount: Int = userStats.numberOfReadItem
            let itemRead: [String: Int] = userStats.itemReads
            self.setItemStats(addAmount: addAmount, readAmount: readAmount, itemRead: itemRead)
        }
    }
    func setReadItem(id: String) {
        var tempDictionary: [String: Int] = [:]
        if let userStats = stats {
            print("read itme")
            let addAmount: Int = userStats.numberOfAddedItem
            var readAmount: Int = userStats.numberOfReadItem
            readAmount += 1
            if findItemById(id: id) {
                tempDictionary = incReadItem(id: id, dic: userStats.itemReads)
            } else {
                for (key, value) in userStats.itemReads {
                    tempDictionary[key] = value
                }
                tempDictionary[id] = 1
            }
            self.setItemStats(addAmount: addAmount, readAmount: readAmount, itemRead: tempDictionary)
        }
    }
    private func findItemById(id: String) -> Bool {
        for (key, _) in stats!.itemReads {
            if key == id {
                print("jest")
                return true
            }
        }
        return false
    }
    private func incReadItem(id: String, dic: [String: Int]) -> [String: Int]{
        var temp: [String: Int] = [:]
        for (key, value) in dic {
            if key == id {
                let val = value + 1
                temp[key] = val
            } else {
                temp[key] = value
            }
        }
        return temp
    }
    private func setItemStats(addAmount: Int, readAmount: Int, itemRead: [String: Int]) {
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
    func reverseIdToName() {
        self.itemStat.removeAll()
        if let stat = stats {
            for item in items {
                print("\(item)")
                for (key, value) in stat.itemReads {
                    print("\(key)")
                    if item.id == key {
//                        self.itemStat[item.name] = value
                        let s = Stats(itemName: item.name, numberOfRead: value)
                        self.itemStat.append(s)
                    }
                }
            }
        }
    }
}
