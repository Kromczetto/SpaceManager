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
    
    @Published var userEmail: String = ""
    
    func whoAmI() {
        if let email = Auth.auth().currentUser?.email {
            userEmail = email
        } else {
            userEmail = ""
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
