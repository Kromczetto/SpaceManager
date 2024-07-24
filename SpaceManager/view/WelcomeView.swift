//
//  WelcomeView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 08/07/2024.
//

import SwiftUI

struct WelcomeView: View {
    
    @StateObject var generatorViewModel = GeneratorViewModel()
    @EnvironmentObject var permissionViewModel: PermissionViewModel
    //@EnvironmentObject var storageManager: StorageManager
    var body: some View {
        BottomMenu()
//            .onAppear {
//                permissionViewModel.getPermission()
//            }
            .environmentObject(generatorViewModel)
            .environmentObject(permissionViewModel)
            //.environmentObject(storageManager)
    }
}

#Preview {
    WelcomeView()
}
