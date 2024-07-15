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
    
    @Published var canUserAdd: Bool = true
    @Published var canUserRead: Bool = true
    @Published var canUserAdmin: Bool = false

    func getPermission() {
          guard let userID = Auth.auth().currentUser?.uid else {
              return
          }
          
          let db = Firestore.firestore()
          let userRef = db.collection("users").document(userID)
          
          userRef.getDocument { (document, err) in
              if let document = document, document.exists {
                  do {
                      self.userDetails = try document.data(as: User.self)
                  } catch {
                      print("error")
                  }
              } else {
                  print("No collection perm")
              }
             
              if let perm = self.userDetails?.permission {
                  self.checkPermission(permission: perm)
              }
          }
      }
    func checkPermission(permission: Permission) {
//        print(permission)
        if permission == Permission.Adder || permission == Permission.Full || permission == Permission.Admin {
            canUserAdd = true
        } else {
            canUserAdd = false
        }
        if permission == Permission.Reader || permission == Permission.Full || permission == Permission.Admin {
            canUserRead = true
        } else {
            canUserRead = false
        }
        if permission == Permission.Admin {
            canUserAdmin = true
        } else {
            canUserAdmin = false
        }
    }

}
