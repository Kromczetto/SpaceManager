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

class PermissionViewModel: ObservableObject {
    @Published var userDetails: User?
    @Published var canUserAdd: Bool = true
    @Published var canUserRead: Bool = true
    @Published var canUserAdmin: Bool = false

    init() { getPermission() }
    
    func getPermission() {
        print("Getting perm...")
          guard let userID = Auth.auth().currentUser?.uid else {
              return
          }
          let db = Firestore.firestore()
          let userRef = db.collection("users").document(userID)
          userRef.getDocument { (document, err) in
              if let document = document, document.exists {
                  do {
                      self.userDetails = try document.data(as: User.self)
                      if let perm = self.userDetails?.permission {
                          self.checkPermission(permission: perm)
                      }
                  } catch {
                      print("error")
                  }
              } else {
                  print("No collection perm")
              }
          }
      }
    private func checkPermission(permission: Permission) {
        DispatchQueue.main.async {
            print(permission)
            if permission == .Adder || permission == .Full || permission == .Admin {
                self.canUserAdd = true
            } else {
                self.canUserAdd = false
            }
            if permission == .Reader || permission == .Full || permission == .Admin {
                self.canUserRead = true
            } else {
                self.canUserRead = false
            }
            if permission == .Admin {
                self.canUserAdmin = true
            } else {
                self.canUserAdmin = false
            }
        }
    }
}
