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
    var body: some View {
        BottomMenu()
            .environmentObject(generatorViewModel)
            .environmentObject(permissionViewModel)
    }
}

#Preview {
    WelcomeView()
}
