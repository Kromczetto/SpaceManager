//
//  ProfileListBtn.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 14/10/2024.
//

import SwiftUI

struct ProfileListBtn: View {
        @State var name: String
        @Binding var tempBool: Bool
        private let bg: Color = Color(red: 0, green: 0, blue: 0, opacity: 0.1)
        var body: some View {
        Button {
            tempBool = true
        } label: {
            ZStack {
                Text(name)
                    .frame(width: 350, height:60)
                    .background(bg)
                    .foregroundStyle(.black)
                    .cornerRadius(15)
                    .foregroundStyle(.white)
                    .padding([.top, .bottom], 10)
                    .bold()
                    .font(.system(size: 16))
            }
        }
    }
}
