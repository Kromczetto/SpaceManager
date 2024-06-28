//
//  CameraView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 28/06/2024.
//

import SwiftUI
import CodeScanner

struct CameraView: View {
    @EnvironmentObject var cameraViewModel: CameraViewModel
    
    var body: some View {
        CodeScannerView(
            codeTypes: [.qr],
            completion: {
                result in
                if case let .success(code) = result {
                    cameraViewModel.messageFromQR = code.string
                    cameraViewModel.isCameraOpen = false
                }
            }
        )
    }
}

#Preview {
    CameraView()
}
