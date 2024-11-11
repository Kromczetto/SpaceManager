//
//  SettingsViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 11/11/2024.
//

import Foundation
import FirebaseAuth
class SettingsViewModel: ObservableObject {
    private let user = Auth.auth().currentUser
    @Published var password: String = ""
    @Published var newPassword: String = ""
    @Published var status: Bool = false
    @Published var message: String = ""
    func reAuth() {
        if let email = user?.email {
            let credential = EmailAuthProvider.credential(withEmail: email, password: self.password)
            user?.reauthenticate(with: credential) { (res, err) in
                if let err = err {
                    print(err.localizedDescription)
                    self.message = "Nie poprawne obecne hasło"
                    self.status = true
                } else {
                    self.changePassword(password: self.newPassword)
                }
            }
        } else {
            self.message = "Problem ze zmiena hasla"
            self.status = true
            print("Problem z zmianna hasła")
        }
    }
    private func changePassword(password: String) {
        Auth.auth().currentUser?.updatePassword(to: password) { (error) in
            if let error = error {
                print(error.localizedDescription)
                self.message = "Problem ze zmiena hasla"
                self.status = true
            }
            self.message = "Hasło zmienione"
            self.status = true
        }
    }
}
