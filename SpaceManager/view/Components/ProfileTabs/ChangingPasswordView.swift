//
//  ChangingPasswordView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 11/11/2024.
//

import SwiftUI

struct ChangingPasswordView: View {
    @State private var click: Bool = false
    @State private var forgetPassword: Bool = false
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @StateObject var valid = RegisterViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Spacer()
            Form {
                SecureField("Stare hasło", text: $settingsViewModel.password)
                    .multilineTextAlignment(.center)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                SecureField("Nowe hasło", text: $settingsViewModel.newPassword)
                    .multilineTextAlignment(.center)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .onTapGesture {
                        click = true
                    }
            }
            Spacer()
            if click {
                Text(valid.passwordValid(password: settingsViewModel.newPassword).message)
            }
            Spacer()
            SettingsBtn(labelBtn: "Zapomniałem hasła", colorBtn: .white) {
                forgetPassword = true
            }.background(.blue)
                .frame(width: 300, height:60)
                .foregroundStyle(.white)
                .cornerRadius(15)
            NavigationLink(destination: ForgotPasswordView()
                                            .environmentObject(settingsViewModel)
                                            .navigationBarBackButtonHidden(true),
                                            isActive: $forgetPassword) {
                                                EmptyView()
            }
            SettingsBtn(labelBtn: "Zmień hasło", colorBtn: .black) {
                settingsViewModel.reAuth()
            }.disabled(!valid.passwordValid(password: settingsViewModel.newPassword).state)
                .opacity(valid.passwordValid(password: settingsViewModel.newPassword).state ? 1 : 0.1)
            Spacer()
        }.alert("\($settingsViewModel.message.wrappedValue)", isPresented: $settingsViewModel.statusOK) {
                Button("OK", role: .cancel) {
                    settingsViewModel.password = ""
                    settingsViewModel.newPassword = ""
                    dismiss()
                }
          }
        .alert("\($settingsViewModel.message.wrappedValue)", isPresented: $settingsViewModel.statusFail) {
                Button("OK", role: .cancel) {}
          }
    }
}

#Preview {
    ChangingPasswordView()
}
