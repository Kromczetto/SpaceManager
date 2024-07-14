//
//  PermissionViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 10/07/2024.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class PermissionViewModel: ObservableObject{
    @Published var userDetails: User?
    
    private func getPermission(){
        
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users")
                        .document(userID)
        
        userRef.getDocument { (document, err) in
            if let document = document, document.exists {
                do{
                    self.userDetails = try document.data(as: User.self)
                  
                } catch{
                  print("error")
                }
            }else{
                print("No collection")
            }
        }
    }
    func returnPermission()->Permission{
        getPermission()
        
        if let userDetails = userDetails {
            return userDetails.permission
        }
        return .Error
    }
}
