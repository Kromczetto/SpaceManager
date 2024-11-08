//
//  AuthView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 08/11/2024.
//

import SwiftUI

struct AuthView: View {
    @State private var isLogin: Bool = true
    @State private var isForgetPassword: Bool = false
    @StateObject var authViewModel = AuthViewModel()
    var body: some View {
        if isLogin && !isForgetPassword {
            LoginView()
            Button {
                isLogin.toggle()
            } label: {
                Text("Nie mam konta")
            }
            Button {
                isForgetPassword.toggle()
            } label: {
                Text("Nie pamietam hasla")
            }
        } else if !isLogin && !isForgetPassword {
            RegisterView()
            Button {
                isLogin.toggle()
            } label: {
                Text("Mam juz konto")
            }
        } else {
            ForgotPasswordView()
            Button {
                isLogin = true
                isForgetPassword = false
            } label: {
                Text("Mam juz konto")
            }
            Button {
                isForgetPassword.toggle()
            } label: {
                Text("Nie mam kontaa")
            }
        }
    }
}

