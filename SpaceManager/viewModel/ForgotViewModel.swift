//
//  ForgotViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 09/07/2024.
//

import Foundation
import Firebase
import FirebaseAuth

class ForgotViewModel: ObservableObject{
    @Published var email: String = ""
    @Published var message: String = ""
    @Published var isSuccess: Bool = false
    @Published var isProblem: Bool = false
    
    func resetPassword(){
        guard valid() else { return }
        Auth.auth().sendPasswordReset(withEmail: email){
            error in

            if(error == nil){
                self.isSuccess = true
            } else {
                self.isSuccess = false
            }
        }
    }
    private func valid() -> Bool {
        if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            message = "Email nie może być pusty"
            isProblem = true
            return false
        }
        let range = NSRange(location: 0, length: email.utf16.count)
        let regexPattern = "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}"
        do {
            let regex = try NSRegularExpression(pattern: regexPattern)
            
            let conditon =  regex.firstMatch(in: email, options: [], range: range) != nil
            if(conditon){
                isProblem = false
                return true
            }else{
                message = "Niepoprawny format"
                isProblem = true
                return false
            }
        } catch {
            return false
        }
    }

    init(){
    }
}
