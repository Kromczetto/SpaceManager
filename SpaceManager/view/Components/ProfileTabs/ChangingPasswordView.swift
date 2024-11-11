//
//  ChangingPasswordView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 11/11/2024.
//

import SwiftUI

struct ChangingPasswordView: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
   
    var body: some View {
        VStack {
            Spacer()
            Form {
                TextField("Stare hasło", text: $settingsViewModel.password)
                TextField("Nowe hasło", text: $settingsViewModel.newPassword)
            }
            Spacer()
            SettingsBtn(labelBtn: "Zmień hasło", colorBtn: .black) {
                settingsViewModel.reAuth() 
            }
            Spacer()
        }.alert("\($settingsViewModel.message.wrappedValue)", isPresented: $settingsViewModel.status) {
                Button("OK", role: .cancel) {}
          }
    }
}

#Preview {
    ChangingPasswordView()
}
