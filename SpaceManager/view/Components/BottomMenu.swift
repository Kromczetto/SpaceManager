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
