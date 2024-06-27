//
//  FormComponent.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 17/04/2024.
//

import Foundation
import SwiftUI

struct FormComponent: View {
    
 
    @State private var repeatedPassword: String = ""
    //viewModel of Login
    @StateObject private var loginHandler = LoginViewModel()
    @StateObject private var registerHandler = RegisterViewModel()
   
    
    
    var isRegister: Bool = true
    
    var body: some View{
        Form{
            TextField("Email", text: $loginHandler.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.system(size: 25))
                .multilineTextAlignment(.center)
                
            SecureField("Hasło", text: $loginHandler.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.system(size: 25))
                .multilineTextAlignment(.center)
                
            if(isRegister){
                SecureField("Powtorz haslo", text: $repeatedPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.system(size: 25))
                    .multilineTextAlignment(.center)
            }
            isRegister ? BtnClearComponet(btnText: "Zarejestruj się", 
                                          btnRegister: isRegister,
                                          email: $loginHandler.email,
                                          password: $loginHandler.password,
                                          loginHandler: loginHandler,
                                          registerHandler: registerHandler)
            
                .padding(.bottom, 5) :
            BtnClearComponet(btnText: "Zaloguj się",
                             email: $loginHandler.email,
                             password: $loginHandler.password,
                             loginHandler:loginHandler,
                             registerHandler: registerHandler)
            .padding(.bottom, 5)
        }
        .frame(width:350,height:400)
        .scrollContentBackground(.hidden)
        .padding(.top, 50)
        
    }
}

