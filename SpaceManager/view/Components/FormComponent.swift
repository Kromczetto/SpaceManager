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
    @EnvironmentObject var permissionViewModel: PermissionViewModel
    
    
    var isRegister: Bool = true
    
    var body: some View{
        Form{
            TextField("Email", text: isRegister ? $registerHandler.email : $loginHandler.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.system(size: 25))
                .multilineTextAlignment(.center)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                
            SecureField("Hasło", text: isRegister ? $registerHandler.password : $loginHandler.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.system(size: 25))
                .multilineTextAlignment(.center)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                
            if(isRegister){
                SecureField("Powtórz haslo", text: $registerHandler.repeatedPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.system(size: 25))
                    .multilineTextAlignment(.center)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            
            BtnClearComponet(btnText: isRegister ? "Zarejestruj się" : "Zaloguj się",
                                       btnRegister: isRegister,
                                       action: {
                                          if isRegister {
                                              registerHandler.registerUser() {
                                                  permissionViewModel.getPermission()
                                              }
                                          } else {
                                              loginHandler.userLogin() {
                                                  permissionViewModel.getPermission()
                                              }
                                          }
                                       },
                                       loginHandler: loginHandler,
                                       registerHandler: registerHandler
            )
                .padding(.bottom, 5)

        }
        .frame(width:350,height:400)
        .scrollContentBackground(.hidden)
        .padding(.top, 50)
        
    }
}

