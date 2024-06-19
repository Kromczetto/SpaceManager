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
        Auth.auth().createUser(withEmail: email,
                               password: password){
            authResult, error in
            if(error != nil){
                print(error?.localizedDescription)
            }else{
                print("utworzono uztkowniak")
            }
        }
    }
    
   
}
