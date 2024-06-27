//
//  MainViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 03/05/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class MainViewModel: ObservableObject{
    @Published var logged = false
    @Published var idOfCurrentUser: String  = ""
    @Published var whichView: Int = 1
    
    @Published var itemName: String = ""
    @Published var numberOfItems: String = ""
    @Published var weight: String = ""
    @Published var comments: String = ""
    
    @Published var isSuccess: Bool = false
    @Published var isFail: Bool = false
    
    private var handler = Auth.auth().addStateDidChangeListener{_,_ in}
    
    init(){
        self.handler = Auth.auth().addStateDidChangeListener{auth, user in
//            print("zmiana")
            self.idOfCurrentUser=user?.uid ?? ""
            self.logged=true
//            print(self.idOfCurrentUser)
        }
    }
    func isUserLogged() -> Bool{
        if(Auth.auth().currentUser != nil){
            return true
        }
        return false
    }
    //Valid adding items fild
    
    func addItemToDatabase(){

        let itemID = UUID().uuidString
        guard let userID = Auth.auth().currentUser?.uid else{
            return
        }
        guard let userName = Auth.auth().currentUser?.email else{
            return
        }
        
        let newItem = Item(id:itemID,
                           name: itemName,
                           amount: numberOfItems,
                           nameOfAdder: userName,
                           commentsToItem: comments,
                           productWeight: weight,
                           addDate: Date(),
                           isDone: false
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
                      "addDate": newItem.addDate
            ]){ error in
                if let error = error {
                    self.isSuccess = false
                    self.isFail = true
                } else {
                    self.isSuccess = true
                    self.isFail = false
                }
            }
        
        
    }
}
