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
    @Published var loginSucces: Bool = false
    func inputValid() -> Bool {
        if(email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
           password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
            message = "Żadne pole nie może być puste"
            isFail = true
            return false
        }
        return true
    }
    func userLogin(completion: @escaping () -> Void) {
        guard inputValid() else { return }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                print(error.localizedDescription)
                self!.message = "Błędny email lub hasło"
                self!.isFail = true
                self!.loginSucces = false
            } else {
                self!.loginSucces = true
                completion()
            }
        }
    }    
}
