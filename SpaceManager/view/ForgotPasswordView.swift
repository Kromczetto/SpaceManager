//
//  ForgotPasswordView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 17/04/2024.
//

import SwiftUI
import FirebaseAuth
struct ForgotPasswordView: View {
    @StateObject var forgotViewModel = ForgotViewModel()
    @State var tempEmail = ""
    @State private var isSignin: Bool = false
    var body: some View {
        VStack {
            Text("Wpisz swój Email:")
                .padding(20)
                .font(.system(size: 25))
            Spacer()
            Form {
                if isSignin {
                    HStack {
                        Spacer()
                        if let email = Auth.auth().currentUser?.email {
                            Text("\(email)")
                                .onAppear {
                                    forgotViewModel.email = email
                                }
                        }
                        Spacer()
                    }
                } else {
                    TextField("Email", text: $forgotViewModel.email)
                        .font(.system(size: 25))
                        .multilineTextAlignment(.center)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                Button {
                    forgotViewModel.resetPassword()
                    tempEmail = forgotViewModel.email
                    forgotViewModel.email = ""
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.blue)
                            .padding(10)
                            .frame(width: 350, height: 80)
                        Text("Zresetuj hasło")
                            .foregroundStyle(.white)
                            .padding()
                            .bold()
                            .font(.system(size: 16))
                    }
                }
            }.alert("Twoje haslo zostało wysłane na email: \($tempEmail.wrappedValue)",
                      isPresented: $forgotViewModel.isSuccess) {
                              Button("OK", role: .cancel) { }
                    }
              .alert("\($forgotViewModel.message.wrappedValue)",
                isPresented: $forgotViewModel.isProblem) {
                        Button("OK", role: .cancel) { }
              }
        }.navigationBarItems(leading: CustomBack(title: "Wróć"))
            .onAppear {
                if let sign = Auth.auth().currentUser?.email {
                    isSignin = true
                } else {
                    isSignin = false
                }
            }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
