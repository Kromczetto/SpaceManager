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
    var action: ()->Void

    @ObservedObject var loginHandler: LoginViewModel
    @ObservedObject var registerHandler: RegisterViewModel
  
    
    var body: some View{
        Button{
            action()
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
        .alert("\(btnRegister ? $registerHandler.message.wrappedValue : $loginHandler.message.wrappedValue)",
               isPresented: btnRegister ? $registerHandler.isFail : $loginHandler.isFail) {
                       Button("OK", role: .cancel) { }
        }
    }
}
