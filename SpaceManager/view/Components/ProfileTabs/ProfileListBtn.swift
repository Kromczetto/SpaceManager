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
        var body: some View {
        Button {
            tempBool = true
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.gray)
                    .padding(5)
                    .frame(width: 500, height: 80)
                Text(name)
                    .foregroundStyle(.white)
                    .padding()
                    .bold()
                    .font(.system(size: 16))
            }
        }
    }
}

//#Preview {
//    ProfileListBtn(name: "favourtie")
//}
