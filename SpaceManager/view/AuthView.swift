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
            HStack {
                Spacer()
                BtnUnderlineComponent(btnText: "Nie mam konta") {
                    isLogin.toggle()
                }
                Spacer()
                BtnUnderlineComponent(btnText: "Nie pamietam hasla") {
                    isForgetPassword.toggle()
                }
                Spacer()
            }.padding([.top, .bottom], 15)
        } else if !isLogin && !isForgetPassword {
            RegisterView()
            BtnUnderlineComponent(btnText: "Mam juz konto") {
                isLogin.toggle()
            }.padding([.top, .bottom], 15)
        } else {
            ForgotPasswordView()
            HStack {
                BtnUnderlineComponent(btnText: "Mam juz konto") {
                    isLogin = true
                    isForgetPassword = false
                }
                BtnUnderlineComponent(btnText: "Nie mam konta") {
                    isLogin = false
                    isForgetPassword.toggle()
                }
            }.padding([.top, .bottom], 15)
        }
    }
}

