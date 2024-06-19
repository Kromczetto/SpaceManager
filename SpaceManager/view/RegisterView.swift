//
//  RegisterView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 03/04/2024.
//

import SwiftUI

struct RegisterView: View {
    var body: some View {
        ZStack{
            LinearGradient(colors: [Color("ligtherGray"),Color("deepGray")],
                           startPoint: .top, endPoint: UnitPoint.bottom)
                            .ignoresSafeArea()
            VStack{
                HeaderComponent(headerText: "Zarejestruj się",
                                headerTopPadding: 160)
                Spacer()
                FormComponent(isRegister: true)
                
                Spacer()
                
                BtnUnderlineComponent(btnText: "Mam już konto",
                                      btnTextSize: 18,
                                        destinationView: AnyView(LoginView()))
                .padding(.bottom, 140)
               
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
