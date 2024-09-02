//
//  LoginPage.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 03/04/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [Color("ligtherGray"),Color("deepGray")],
                               startPoint: .top, endPoint: UnitPoint.bottom)
                                .ignoresSafeArea()
                VStack {
                    HeaderComponent(headerText: "Zaloguj się")
                    Spacer()
                    FormComponent(isRegister: false)
                    Spacer()
                    HStack {
                        BtnUnderlineComponent(btnText: "Zapomniałem hasła",
                                              destinationView: AnyView(ForgotPasswordView()))
                                                .padding()
                        BtnUnderlineComponent(btnText: "Zarejestruj się",
                                              destinationView: AnyView(RegisterView()))
                        
                    }.padding(.bottom, 140)
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

