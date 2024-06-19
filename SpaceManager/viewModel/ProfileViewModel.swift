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

    func loggout(){
        do{
            try Auth.auth().signOut()
//            logManager.logged = false
        }catch{
            print("Problem with siging out")
        }
    }
}
