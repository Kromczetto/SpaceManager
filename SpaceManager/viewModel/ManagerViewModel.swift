//
//  ManagerViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 29/10/2024.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
class ManagerViewModel: ObservableObject {
    private var users: [User] = []
    @Published var publicUsers: [User] = []
    @Published var items: [Item] = []
    @Published var favourties: [Favourite] = []
    private let db = Firestore.firestore()
    func getUsers() {
        print("Getting users...")
        users.removeAll()
        publicUsers.removeAll()
        let docRef =  db.collection("users")
            .getDocuments { (snap, err) in
                snap?.documents.forEach({doc in
                    let dictionary = doc.data()
                    var tempPermission = Permission(rawValue: dictionary["permission"] as! String)
                    var user: User = User(uid: dictionary["uid"] as! String,
                                          email: dictionary["email"] as! String,
                                          permission: tempPermission!)
                    self.users.append(user)
                    self.publicUsers.append(user)
                })
            }
    }
    func getItems(uid: String) {
        items.removeAll()
        print("W gecie \(uid)")
        let docRef = db.collection("users")
            .document(uid)
            .collection("items")
            .getDocuments { (snap, err) in
                snap?.documents.forEach({doc in
                    let dictionary = doc.data()
//                    print(dictionary)
                    if !dictionary.isEmpty {
                        var item: Item = Item(id: dictionary["id"] as! String,
                                              name: dictionary["name"] as! String,
                                              amount: dictionary["amount"] as! String,
                                              nameOfAdder: dictionary["nameOfAdder"] as! String,
                                              commentsToItem: dictionary["commentsToItem"] as! String,
                                              productWeight: dictionary["productWeight"] as! String,
                                              addDate: Date(),
                                              properties: [])
                        self.items.append(item)
                    } else {
                        return
                    }
                })
            }
    }
    func findEmail(email: String) {
        if email == "" {
            getUsers()
            return
        }
        publicUsers.removeAll()
//        var tempUser: String = ""
        for (index, user) in users.enumerated() {
            let mail = user.email.lowercased()
            if mail.contains(email.lowercased()) {
                publicUsers.append(users[index])
            }
        }
    }
    func updateUser(uid: String, email: String, permission: Permission) {
        let updatedUser = User(uid: uid, email: email, permission: permission)
        print(updatedUser)
        DispatchQueue.main.async {
            let db = Firestore.firestore()
            db.collection("users")
                .document(uid)
                .setData(updatedUser.toDictionary())
        }
    }
    func deleteUser(uid: String) {
        db.collection("users").document(uid).delete() { err in
            if let err = err {
                print(err.localizedDescription)
            } else {
                print("Deleted user")
            }
        }
        
//        let user = Auth.auth().currentUser
//        print(user)
//        user?.delete { err in
//            if let err = err {
//                print(err.localizedDescription)
//            } else {
//                print("User deleted")
//            }
//        }
    }
    func changePassword() {
        
    }
}