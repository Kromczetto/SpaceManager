//
//  MainView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 24/07/2024.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var staySignin = StaySigninViewModel()
    @StateObject var permissionViewModel = PermissionViewModel()
    var body: some View {
        if (!staySignin.isUserLogged() || staySignin.idOfCurrentUser.isEmpty) {
            LoginView()
                .environmentObject(permissionViewModel)
        } else {
            WelcomeView()
                .environmentObject(permissionViewModel)
        }
    }
}

#Preview {
    MainView()
}
