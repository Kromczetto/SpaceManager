//
//  LoginViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 28/04/2024.
//

import Foundation
import Firebase
import FirebaseAuth

class LoginViewModel : ObservableObject {
    @Published var email = ""
    @Published var password = ""
 
    
    func inputValid() -> Bool{
        if(email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty){
            
           //Type email regex validation
            return false
        }else{
            
            return true;
        }
        
    }
    
    func userLogin(email: String, password: String)->(){
        guard inputValid() else{ return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            //print(error?.localizedDescription)
                //guard let strongSelf = self else { return
                if let error = error {
                    print(error.localizedDescription)
                }else{
                        print("\(email), \(password)")
                    }
                //(self?.logged = true)!
            
           // }
            
        }
        
    }
    
}
