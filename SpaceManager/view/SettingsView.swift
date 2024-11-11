//
//  SettingsView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 14/10/2024.
//

import SwiftUI
import FirebaseAuth
struct SettingsView: View {
    @State var changePassword: Bool = false
    @State var deleteAccount: Bool = false
    @StateObject var settingsViewModel = SettingsViewModel()
    var body: some View {
        SettingsBtn(labelBtn: "Zmień hasło", colorBtn: .black) {
            changePassword = true
        }
        NavigationLink(destination: ChangingPasswordView()
                                        .environmentObject(settingsViewModel)
                                        .navigationBarBackButtonHidden(true)
                                        .navigationBarItems(leading: CustomBack(title:"Wróć")),
                                        isActive: $changePassword) {
                                            EmptyView()
        }
        SettingsBtn(labelBtn: "Usuń konto") {
            deleteAccount = true
        }.alert(isPresented: $deleteAccount) {
            Alert(
                title: Text("Czy na pewno chcesz usunąć konto?"),
                message: Text("Jest to operacja nie odwracalna"),
                primaryButton: .destructive(Text("Usuń")) {
                    settingsViewModel.deleteUser()
                },
                secondaryButton: .cancel(Text("Cofnij"))
            )
        }
    }
}


