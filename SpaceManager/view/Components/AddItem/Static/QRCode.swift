//
//  QRCode.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 03/09/2024.
//

import SwiftUI

struct QRCode: View {
    @Binding var productID: String
    @EnvironmentObject var qrCodeGenerator: QrCodeGenerator
    var body: some View {
        GeometryReader { geometry in
            Image(uiImage: qrCodeGenerator.generatorQr(from: productID)!)
                .resizable()
                .interpolation(.none)
                .scaledToFit()
                .frame(width: 200, height: 200)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }.frame(minHeight: 200)
    }
}

