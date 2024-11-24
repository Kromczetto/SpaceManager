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
    @Published var arrayOfFid: [String] = []
    @Published var isOnList: Bool = false
    @Published var isDeleting: Bool = false
    func getState() -> Bool {
        return isOnList
    }
    func setFavouriteItem(newFavourite: String, itemID: String) {
        var favourite = Favourite(fid: itemID, favourites: "")
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
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
        arrayOfFid.removeAll()
        arrayOfFavourtieItem.removeAll()
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let docRef = db.collection("users")
            .document(uid)
            .collection("favourite")
            .getDocuments { (snap, err) in
                snap?.documents.forEach({ doc in
                    let dictionary = doc.data()
                    if let favouriteName = dictionary["favourites"] as? String {
                        self.arrayOfFavourtieItem.append(favouriteName)
                    }
                    if let fids = dictionary["fid"] as? String {
                        self.arrayOfFid.append(fids)
                    }
                })
            }
    }
    func deleteFavouriteItem(itemID: String) {
        self.isOnList = false
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
    func isOnFavouriteList(id: String) {
        for f in arrayOfFid {
            if f == id {
                self.isOnList = true
                return
            }
            else {
                self.isOnList = false
            }
        }
    }
}
