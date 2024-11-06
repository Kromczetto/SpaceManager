//
//  AuthViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 05/11/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchData()
        }
    }
    func signIn(email: String, password: String) async throws {
        
    }
    func register(email: String, password: String, repetedPassword: String) async throws {
        do {
            let res = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = res.user
            let newUser = User(uid: res.user.uid, email: email, permission: Permission.Admin, itemReads: [["Prop":2]], numberOfAddedItem: 0, numberOfReadItem: 0)
            let encodedUser = try Firestore.Encoder().encode(newUser)
            try await Firestore.firestore().collection("users")
                                            .document(newUser.uid)
                                            .setData(encodedUser)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    func signOut() {
        
    }
    func fetchData() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return}
        self.currentUser = try? snapshot.data(as: User.self)
    }
}
