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
    @Published var logged = false
    @Published var idOfCurrentUser: String  = ""
        private var handler = Auth.auth().addStateDidChangeListener{_,_ in}
    
          init(){
              self.handler = Auth.auth().addStateDidChangeListener{auth, user in
                  self.idOfCurrentUser=user?.uid ?? ""
                  self.logged=true
              }
          }
          func isUserLogged() -> Bool{
              if(Auth.auth().currentUser != nil){
                  return true
              }
              return false
          }
}
