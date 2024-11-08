//
//  MainView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 24/07/2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var staySignin: StaySigninViewModel
    var body: some View {
        if (!staySignin.isUserLogged() || staySignin.idOfCurrentUser.isEmpty) {
            AuthView()
        }
        else {
            WelcomeView()
                .environmentObject(staySignin)
        }
    }
}
#Preview {
    MainView()
}
