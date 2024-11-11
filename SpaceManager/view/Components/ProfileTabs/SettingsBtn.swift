//
//  SettingsBtn.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 30/10/2024.
//

import SwiftUI

struct SettingsBtn: View {
    @State var labelBtn: String = ""
    @State var colorBtn: Color = .red
    var action: () -> Void
    private let bg: Color = Color(red: 0, green: 0, blue: 0, opacity: 0.1)
    var body: some View {
        Button {
            action()
        } label: {
            Text(labelBtn)
                .frame(width: 300, height:60)
                .background(bg)
                .foregroundStyle(colorBtn)
                .cornerRadius(15)
        }.padding([.top, .bottom], 10)
    }
}

#Preview {
    SettingsBtn() {
        print("SettingBtn")
    }
}
