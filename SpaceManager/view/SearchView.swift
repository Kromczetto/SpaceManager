//
//  SearchView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 12/05/2024.
//

import SwiftUI
import CodeScanner

struct SearchView: View {
    @State var isCameraOpen: Bool = false
    @State var messageFromQR: String = "id: "
    
    var camera: some View {
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
    
    var body: some View {
        
        VStack{
            Text(messageFromQR)
            Button("Skanuj kod QR"){
                self.isCameraOpen = true
            }
            .sheet(isPresented: $isCameraOpen){
                self.camera
            }
        }
        
    }
}

#Preview {
    SearchView()
}
