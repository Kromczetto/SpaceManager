//
//  SpaceManagerApp.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 03/04/2024.
//

import SwiftUI
import Firebase
import FirebaseCore

@main
struct SpaceManagerApp: App {
    @StateObject var staySignin = StaySigninViewModel()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(staySignin)
        }
    }
}
