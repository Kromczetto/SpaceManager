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

    @EnvironmentObject var permissionViewModel: PermissionViewModel
    var body: some View {
        TabView {
            NavigationView {
                AddNewItemView()
                    .navigationBarBackButtonHidden(true)
            }
            .tabItem {
                Label("Dodaj", systemImage: "plus.app.fill")
            }
            NavigationView {
                SearchView()
                    .navigationBarBackButtonHidden(true)
            }
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
                }                
            }
            NavigationView {
                ProfileView()
                    .navigationBarBackButtonHidden(true)
            }
            .tabItem {
                Label("Profil", systemImage: "person.crop.circle.fill")
            }
        }
    }
}

#Preview {
    BottomMenu()
}
