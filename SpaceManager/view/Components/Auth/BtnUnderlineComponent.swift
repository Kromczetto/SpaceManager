//
//  BtnUnderlineComponent.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 11/04/2024.
//

import Foundation
import SwiftUI

struct BtnUnderlineComponent: View {
    var btnTextColor: Color = .gray
    var btnText: String = "Button"
    var btnTextSize: CGFloat = 16
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Text(btnText)
                .foregroundStyle(btnTextColor)
                .font(.system(size: btnTextSize))
                .underline()
        }
    }
}
