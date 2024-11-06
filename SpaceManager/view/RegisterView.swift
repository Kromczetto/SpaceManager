//
//  RegisterView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 03/04/2024.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("ligtherGray"),Color("deepGray")],
                           startPoint: .top, endPoint: UnitPoint.bottom)
                            .ignoresSafeArea()
            VStack {
                HeaderComponent(headerText: "Zarejestruj się", headerTopPadding: 160)
                Spacer()
                FormComponent(isRegister: true)
                Spacer()
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Mam już konto")
                        .foregroundStyle(.gray)
                        .font(.system(size: 18))
                        .underline()
                }
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
