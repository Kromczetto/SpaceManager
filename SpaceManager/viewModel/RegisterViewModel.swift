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
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var repeatedPassword: String = ""
    
    @Published var isFail: Bool = false
    @Published var message: String = ""
    
    
    func registerUser() -> () {
        
        if(!validInput()){
            return
        }
        Auth.auth().createUser(withEmail: email, password: password){
            [weak self] res, err in
            guard let self = self else { return }
            if let err = err {
                           self.isFail = true
                           self.message = "Błąd przy rejestracji"
                           return
                       }
            guard let userID = res?.user.uid else {
                return
            }
            self.addIntoDatabe(userID: userID, email: email)
        }
    }
    private func validInput() -> Bool {
      
      
        var emailWithoutWhiteCharacters: String{
            email.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        var passwordWithoutWhiteCharacters: String{
            password.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        var repeatedPasswordWithoutWhiteCharacters: String{
            repeatedPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        if(emailWithoutWhiteCharacters.isEmpty ||
           passwordWithoutWhiteCharacters.isEmpty ||
           repeatedPasswordWithoutWhiteCharacters.isEmpty){
            message = "Żadne pole nie może być puste"
            isFail = true
            return false
        }
        return true
    }
    private func addIntoDatabe(userID: String, email: String) {
        let newUser = User(uid: userID, email: email)
        let db = Firestore.firestore()
        db.collection("users")
            .document(userID)
            .setData(["uid": newUser.uid, "email": newUser.email])
    }
}
