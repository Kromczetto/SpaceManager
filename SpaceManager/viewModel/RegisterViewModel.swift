//
//  RegisterViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 03/05/2024.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class RegisterViewModel : ObservableObject {
    @Published var email=""
    @Published var password=""
    @Published var repeatedPassword=""
    
    func registerUser(email: String, password: String) -> () {
        Auth.auth().createUser(withEmail: email, password: password){
            [weak self] res, err in
            
            guard let userID = res?.user.uid else {
                return
            }
            self?.addIntoDatabe(userID: userID, email: email)
        }
    }
    private func addIntoDatabe(userID: String, email: String){
        let newUser = User(uid: userID, email: email)
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(userID)
            .setData(["uid": userID, "email": email])
        
    }
}
