//
//  WelcomeView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 08/07/2024.
//

import SwiftUI

struct WelcomeView: View {
    @StateObject var permissionViewModel = PermissionViewModel()
    @StateObject var statsViewModel = StatsViewModel()
    @EnvironmentObject var staySignin: StaySigninViewModel
    var body: some View {
        if permissionViewModel.userDetails == nil {
            LoadingView()
        } else {
            BottomMenu()
                .onAppear {
                    permissionViewModel.getPermission()
                }
                .environmentObject(permissionViewModel)
                .environmentObject(staySignin)
                .environmentObject(statsViewModel)            
        }
    }
}

#Preview {
    WelcomeView()
}
