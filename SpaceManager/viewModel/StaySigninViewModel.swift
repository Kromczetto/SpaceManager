//
//  StaySigninViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 14/07/2024.
//

import Foundation
import Firebase
import FirebaseAuth

class StaySigninViewModel: ObservableObject{
    @Published var idOfCurrentUser: String  = ""
    private var handler = Auth.auth().addStateDidChangeListener{_,_ in}
    init() {
        self.handler = Auth.auth().addStateDidChangeListener { auth, user in
            self.idOfCurrentUser = user?.uid ?? ""
        }
    }
    func isUserLogged() -> Bool {
        if let auth = Auth.auth().currentUser {
            return true
        }
        return false
    }
    
}
