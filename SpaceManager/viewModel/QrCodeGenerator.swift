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
    func generatorQr(from input: String) -> UIImage? {
        let context = CIContext()
           let filter = CIFilter.qrCodeGenerator()
           filter.message = Data(input.utf8)
           if let outputImage = filter.outputImage {
               let size = CGSize(width: 200, height: 200)
               let scaleX = size.width / outputImage.extent.size.width
               let scaleY = size.height / outputImage.extent.size.height
               let transformedImage = outputImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
               if let cgImage = context.createCGImage(transformedImage, from: transformedImage.extent) {
                   let uiImage = UIImage(cgImage: cgImage)
                   UIGraphicsBeginImageContext(size)
                   uiImage.draw(in: CGRect(origin: .zero, size: size))
                   let scaledUIImage = UIGraphicsGetImageFromCurrentImageContext()
                   UIGraphicsEndImageContext()
                   return scaledUIImage
               }
           }
           return nil
    }
    init() {
        
    }
}
