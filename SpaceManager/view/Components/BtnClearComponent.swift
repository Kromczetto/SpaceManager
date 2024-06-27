//
//  BtnClearComponent.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 17/04/2024.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

struct BtnClearComponet: View {
    
    var btnTextColor: Color = .white
    var btnBackgroundColor: Color = .green
    var btnText: String = "Button"
    var btnTextSize: CGFloat = 16
    var btnRegister = false
    //var destinationView: AnyView
    
    @Binding var email: String
    @Binding var password: String
    
    @ObservedObject var loginHandler: LoginViewModel
    @ObservedObject var registerHandler: RegisterViewModel
  
    
    var body: some View{
        Button{
            if(btnRegister){
                registerHandler.registerUser(email: $email.wrappedValue,
                                             password: $password.wrappedValue)
                
            }else{
                loginHandler.userLogin(email: $email.wrappedValue, password: $password.wrappedValue)
              
            }
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(btnBackgroundColor)
                    .padding(10)
                Text(btnText)
                    .foregroundStyle(btnTextColor)
                    .padding()
                    .bold()
                    .font(.system(size: btnTextSize))
            }
        }
        .alert("\($registerHandler.message.wrappedValue)",
               isPresented: $registerHandler.isFail) {
                       Button("OK", role: .cancel) { }
        }
    }
}
