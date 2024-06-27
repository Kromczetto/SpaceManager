//
//  QrCodeGenerator.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 04/05/2024.
//

import Foundation
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

class QrCodeGenerator: ObservableObject {
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    
    @Published var itemName = ""
    @Published var numberOfItems = ""
    @Published var resposablePerson = ""
    @Published var comments = ""
    
    func generatorQr(from input: String) -> UIImage {
        
       
        filter.message = Data(input.utf8)

              if let outputImage = filter.outputImage {
                  if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                      return UIImage(cgImage: cgImage)
                  }
              }

              return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    init(){
        
    }
}
