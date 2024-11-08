//
//  LoginPage.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 03/04/2024.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var registerViewModel = RegisterViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [Color("ligtherGray"),Color("deepGray")],
                               startPoint: .top, endPoint: UnitPoint.bottom)
                                .ignoresSafeArea()
                VStack {
                    HeaderComponent(headerText: "Zaloguj się")
                    Spacer()
                    Form {
                        TextField("Email", text: $loginViewModel.email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.system(size: 25))
                            .multilineTextAlignment(.center)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        SecureField("Hasło", text: $loginViewModel.password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.system(size: 25))
                            .multilineTextAlignment(.center)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        BtnClearComponet(btnText: "Zaloguj się", btnRegister: false) {
                            loginViewModel.userLogin() {
                                print("perm log")
                            }
                        }
                        .environmentObject(loginViewModel)
                        .environmentObject(registerViewModel)
                        .padding(.bottom, 5)
                    }
                    .frame(width:350,height:400)
                    .scrollContentBackground(.hidden)
                    .padding(.top, 50)
                    Spacer()
//                    HStack {
//                        BtnUnderlineComponent(btnText: "Zapomniałem hasła",
//                                              destinationView: AnyView(ForgotPasswordView()))
//                                                .padding()
//                        BtnUnderlineComponent(btnText: "Zarejestruj się",
//                                              destinationView: AnyView(RegisterView()))
//                    }.padding(.bottom, 140)
                    Spacer()
                }
            }
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

