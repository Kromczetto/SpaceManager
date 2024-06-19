//
//  TestView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 04/05/2024.
//

import SwiftUI

struct QRCodeGeneratorView: View {
    @State private var inputText: String = ""
    @State private var qrCodeImage: Image?
    
    var body: some View {
        VStack {
            TextField("Wprowadź tekst", text: $inputText, onCommit: generateQRCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if let image = qrCodeImage {
                image
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
            }
        }
    }
    
    private func generateQRCode() {
        if let qrImage = generateQRCodeImage(from: inputText) {
            self.qrCodeImage = Image(uiImage: qrImage)
        } else {
            self.qrCodeImage = nil
        }
    }
    
    private func generateQRCodeImage(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)  // Skalowanie QR kodu
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeGeneratorView()
    }
}
