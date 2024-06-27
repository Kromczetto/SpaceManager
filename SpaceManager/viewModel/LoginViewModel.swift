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
    @Published var email: String = ""
    @Published var password: String = ""
 
    @Published var isFail: Bool = false
    @Published var message: String = ""
    
    func inputValid() -> Bool{
        if(email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty){
            message = "Żadne pole nie może być puste"
            isFail = true
           //Type email regex validation
            return false
        }else{
            
            return true;
        }
        
    }
    
    func userLogin()->(){
        guard inputValid() else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
     
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
    }
    
}
