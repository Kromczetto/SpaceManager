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
    var body: some View {
        Button {
            action()
        } label: {
            Text(labelBtn)
                .foregroundStyle(colorBtn)
        }
    }
}

#Preview {
    SettingsBtn() {
        print("SettingBtn")
    }
}
