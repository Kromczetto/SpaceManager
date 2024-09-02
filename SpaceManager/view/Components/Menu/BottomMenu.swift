//
//  BottomMenu.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 04/05/2024.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct BottomMenu: View {
    @State private var index: Int = 0
    
    @StateObject var permissionViewModel = PermissionViewModel()
    @StateObject var profileViewModel = ProfileViewModel()
   // @EnvironmentObject var storageManager: StorageManager
    
    var body: some View {
        TabView(selection: $index) {
            NavigationView {
                AddNewItemView()
                    .environmentObject(permissionViewModel)
                    .navigationBarBackButtonHidden(true)
            }
            .tabItem {
                Label("Dodaj", systemImage: "plus.app.fill")
            }.tag(0)
            NavigationView {
                SearchView()
                    .environmentObject(permissionViewModel)
                    .navigationBarBackButtonHidden(true)
            }.tag(1)
            .tabItem {
                Label("Szukaj", systemImage: "magnifyingglass")
            }
            if(permissionViewModel.canUserAdmin){
                NavigationView {
                    ManagerView()
                        .navigationBarBackButtonHidden(true)
                }
                .tabItem {
                    Label("Manager", systemImage: "person.badge.shield.checkmark.fill")
                }.tag(2)
            }
            NavigationView {
                ProfileView()
                    .onAppear {
                        profileViewModel.whoAmI()
                    }
                    .environmentObject(profileViewModel)
                    .navigationBarBackButtonHidden(true)
            }
            .tabItem {
                Label("Profil", systemImage: "person.crop.circle.fill")
            }.tag(3)
        }
    }
}

#Preview {
    BottomMenu()
}
