//
//  ProfileViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 16/05/2024.
//

import Foundation
import Firebase
import FirebaseAuth

class ProfileViewModel: ObservableObject{
    func whoAmI()->String{
        if let userEmail = Auth.auth().currentUser?.email {
            return userEmail
        } else {
            return "Nie zalogowany"
        }
    }
    func loggout(){
        do{
            try Auth.auth().signOut()
        }catch{
            print("Wystąpił problem podczas wylogowywania")
        }
    }
}
