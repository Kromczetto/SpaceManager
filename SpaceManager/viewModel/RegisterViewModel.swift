//
//  RegisterViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 03/05/2024.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class RegisterViewModel : ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var repeatedPassword: String = ""
    @Published var isFail: Bool = false
    @Published var message: String = ""
    func registerUser(completion: @escaping () -> Void) {
        if !validInput() {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] res, err in
            guard let self = self else { return }
            if let err = err {
                self.isFail = true
                self.message = "Błąd przy rejestracji \(err.localizedDescription)"
                return
            }
            guard let userID = res?.user.uid else {
                return
            }
            self.addIntoDatabe(userID: userID, email: self.email)
            completion()
        }
    }
    private func validInput() -> Bool {
        var emailWithoutWhiteCharacters: String {
            email.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        var passwordWithoutWhiteCharacters: String {
            password.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        var repeatedPasswordWithoutWhiteCharacters: String {
            repeatedPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        if emailWithoutWhiteCharacters.isEmpty ||
           passwordWithoutWhiteCharacters.isEmpty ||
           repeatedPasswordWithoutWhiteCharacters.isEmpty {
            message = "Żadne pole nie może być puste"
            isFail = true
            return false
        }
        if passwordWithoutWhiteCharacters.count<8 {
            message = "Hasło musi mieć przynajmniej 8 znaków"
            isFail = true
            return false
        }
        var uppercaseCount = 0
        var lowercaseCount = 0
        var digitCount = 0

        for char in passwordWithoutWhiteCharacters {
            if char.isUppercase {
                uppercaseCount += 1
            } else if char.isLowercase {
                lowercaseCount += 1
            } else if char.isNumber {
                digitCount += 1
            }
        }
        if uppercaseCount<2 || lowercaseCount<2 || digitCount<2 {
            message = "Hasło musi mieć przynajmniej dwie małe litery, dwie duże i dwie cyfry"
            isFail = true
            return false
        }
        if passwordWithoutWhiteCharacters != repeatedPasswordWithoutWhiteCharacters {
            message = "Hasło i powtórzone hasło muszą być takie same"
            isFail = true
            return false
        }
        let range = NSRange(location: 0, length: email.utf16.count)
        let regexPattern = "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}"
        do {
            let regex = try NSRegularExpression(pattern: regexPattern)
            
            let conditon =  regex.firstMatch(in: email, options: [], range: range) != nil
            if conditon {
                isFail = false
                return true
            } else {
                message = "Niepoprawny format emailu"
                isFail = true
                return false
            }
        } catch {
            return false
        }
    }
    private func addIntoDatabe(userID: String, email: String) {
        let newUser = User(uid: userID, email: email, permission: Permission.Admin, itemReads: ["Prop":2],
                           numberOfAddedItem: 0, numberOfReadItem: 0)
        let db = Firestore.firestore()
        db.collection("users")
            .document(userID)
            .setData(["uid": newUser.uid, "email": newUser.email, "permission": newUser.permission.rawValue, "itemReads": newUser.itemReads, "numberOfAddedItem": newUser.numberOfAddedItem, "numberOfReadItem": newUser.numberOfReadItem])
        print("User has been added into db")
    }
    func passwordValid(password: String) -> (state: Bool, message: String) {
        var pass: String {
            password.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if pass.isEmpty {
            return (false, "Hasło nie może być puste")
        }
        if pass.count<8 {
            return (false, "Hasło musi mieć przynajmniej 8 znaków")
        }
        var uppercaseCount = 0
        var lowercaseCount = 0
        var digitCount = 0

        for p in pass {
            if p.isUppercase {
                uppercaseCount += 1
            } else if p.isLowercase {
                lowercaseCount += 1
            } else if p.isNumber {
                digitCount += 1
            }
        }
        if uppercaseCount<2 || lowercaseCount<2 || digitCount<2 {
            return (false, "Hasło musi mieć przynajmniej dwie małe litery, dwie duże i dwie cyfry")
        }
        return (true, "")
    }
}
