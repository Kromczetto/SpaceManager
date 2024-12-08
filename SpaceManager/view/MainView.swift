//
//  MainView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 24/07/2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var staySignin: StaySigninViewModel
    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var registerViewModel = RegisterViewModel()
    var body: some View {
        if (!staySignin.isUserLogged() || staySignin.idOfCurrentUser.isEmpty) {
            AuthView()
                .environmentObject(loginViewModel)
                .environmentObject(registerViewModel)
        }
        else {
            WelcomeView()
                .environmentObject(staySignin)
                .environmentObject(loginViewModel)
                .environmentObject(registerViewModel)
        }
    }
}
#Preview {
    MainView()
}
