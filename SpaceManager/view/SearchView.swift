//
//  SearchView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 12/05/2024.
//

import SwiftUI
import CodeScanner
import FirebaseAuth

struct SearchView: View {
    @State var isCameraOpen: Bool = false
    @State var messageFromQR: String = "id: "
    
    @State var isRead: Bool = false
    
    var camera: some View {
        CodeScannerView(
            codeTypes: [.qr],
            completion: {
                result in
                if case let .success(code) = result {
                    self.messageFromQR = code.string
                    self.isCameraOpen = false
                    self.isRead = true
                }
            }
        )
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text(self.messageFromQR)
                Button("Skanuj kod QR") {
                    self.isCameraOpen = true
                }
                .sheet(isPresented: $isCameraOpen) {
                    self.camera
                }
                NavigationLink(destination: ReadItem(messageFromQR: messageFromQR), isActive: $isRead) {
                    EmptyView()
                }
            }
            .navigationBarTitle("Search View")
        }
    }
}

#Preview {
    SearchView()
}
