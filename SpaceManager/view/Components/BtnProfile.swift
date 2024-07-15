//
//  BtnProfile.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 16/05/2024.
//

import SwiftUI

struct BtnProfile: View {
//    var btnEvent: ()->Void
    @ObservedObject var profileView = ProfileViewModel()
    @StateObject var staySignin = StaySigninViewModel()
    var body: some View {
        Button{
            profileView.loggout()
            staySignin.logged = false
        } label:{
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.blue)
                    .padding(10)
                    .frame(width: 350, height: 80)
                Text("wyloguj")
                    .foregroundStyle(.white)
                    .padding()
                    .bold()
                    .font(.system(size: 16))
            }
        }
    }
}

