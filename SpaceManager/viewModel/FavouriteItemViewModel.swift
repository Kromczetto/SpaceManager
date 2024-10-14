//
//  FavouriteItemViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 10/10/2024.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
class FavouriteItemViewModel: ObservableObject {
    @Published var favouriteItems: Favourite?
    @Published var arrayOfFavourtieItem: [String] = []
    func setFavouriteItem(newFavourite: String, itemID: String) {
        var favourite = Favourite(fid: itemID, favourites: "")
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        getFavouriteItems()
        favourite = Favourite(fid: itemID, favourites: newFavourite)
        let db = Firestore.firestore()
        let docRef = db.collection("users")
            .document(uid)
            .collection("favourite")
            .document(favourite.fid)
            .setData(favourite.toDictionary()) { err in
                if let err = err {
                    print(err.localizedDescription)
                }
            }
        
    }
    func getFavouriteItems() {
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        //        let docRef = db.collection("users")
        //            .document(uid)
        //            .collection("favourite")
        //            .getDocuments { (snap, err) in
        //                snap?.documents.forEach({ doc in
        //                    let dictionary = doc.data()
        //                    if let favouriteName = dictionary["name"] as? String {
        //                        self.options.append(favouriteName)
        //                    }
        //                })
        //                var index: Int = 0
        //                for option in self.options {
        //                    self.nameTid[option] = self.tids[index]
        //                    index = index + 1
        //                }
        //            }
        print("DB request :)")
        
    }
    
    func deleteFavouriteItem(itemID: String) {
        print("del")
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        db.collection("users")
            .document(userID)
            .collection("favourite")
            .document(itemID)
            .delete()
    }
    //ADD LOGIC
    func isOnFavouriteList() -> Bool {
        
        return false
    }
}
