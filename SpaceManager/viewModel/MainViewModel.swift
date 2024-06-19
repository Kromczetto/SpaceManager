//
//  MainViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 03/05/2024.
//

import Foundation
import FirebaseAuth

class MainViewModel: ObservableObject{
    @Published var logged = false
    @Published var idOfCurrentUser: String  = ""
    @Published var whichView: Int = 1
    
    private var handler = Auth.auth().addStateDidChangeListener{_,_ in}
    
    init(){
        self.handler = Auth.auth().addStateDidChangeListener{auth, user in
            print("zmiana")
            self.idOfCurrentUser=user?.uid ?? ""
            self.logged=true
            print(self.idOfCurrentUser)
        }
    }
    func isUserLogged() -> Bool{
        if(Auth.auth().currentUser != nil){
            return true
        }
        return false
    }
}
