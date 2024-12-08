//
//  RegisterView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 03/04/2024.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var registerViewModel: RegisterViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("ligtherGray"),Color("deepGray")],
                           startPoint: .top, endPoint: UnitPoint.bottom)
                            .ignoresSafeArea()
            VStack {
                HeaderComponent(headerText: "Zarejestruj się", headerTopPadding: 160)
                Spacer()
                Form {
                    TextField("Email", text: $registerViewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.system(size: 25))
                        .multilineTextAlignment(.center)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    SecureField("Hasło", text: $registerViewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.system(size: 25))
                        .multilineTextAlignment(.center)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    SecureField("Powtórz haslo", text: $registerViewModel.repeatedPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.system(size: 25))
                        .multilineTextAlignment(.center)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    BtnClearComponet(btnText: "Zarejestruj się", btnRegister: true) {
                        registerViewModel.registerUser() {
                            print("Registered")
                        }
                    }.environmentObject(loginViewModel)
                        .environmentObject(registerViewModel)
                        .padding(.bottom, 5)
                }
                .frame(width:350,height:400)
                .scrollContentBackground(.hidden)
                .padding(.top, 50)
                Spacer()
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
