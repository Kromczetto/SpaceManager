//
//  WelcomeView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 08/07/2024.
//

import SwiftUI

struct WelcomeView: View {
    //@StateObject var profileViewModel = ProfileViewModel()
//    @EnvironmentObject var permissionViewModel: PermissionViewModel
    @EnvironmentObject var staySignin: StaySigninViewModel
    @StateObject var permissionViewModel = PermissionViewModel()

    var body: some View {
        BottomMenu()
            .onAppear {
                permissionViewModel.getPermission()
            }
            //.environmentObject(generatorViewModel)
            .environmentObject(permissionViewModel)
            .environmentObject(staySignin)

    }
}

#Preview {
    WelcomeView()
}
