//
//  MainView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 24/07/2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var staySignin: StaySigninViewModel
//    @EnvironmentObject var permissionViewModel: PermissionViewModel

    var body: some View {
        if (!staySignin.isUserLogged() || staySignin.idOfCurrentUser.isEmpty) {
            LoginView()
        } 
        else {
            WelcomeView()
                
//                .environmentObject(permissionViewModel)
                .environmentObject(staySignin)
        }
    }
}

#Preview {
    MainView()
}
