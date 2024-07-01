//
//  CameraView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 28/06/2024.
//

import SwiftUI
import CodeScanner

struct CameraView: View {
    @Binding var messageFromQR: String
    @Binding var isCameraOpen: Bool
    
    var body: some View {
        CodeScannerView(
            codeTypes: [.qr],
            completion: {
                result in
                if case let .success(code) = result {
                    self.messageFromQR = code.string
                    self.isCameraOpen = false
                }
            }
        )
    }
}

