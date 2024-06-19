//
//  QrCodeGenerator.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 04/05/2024.
//

//import Foundation
//import SwiftUI
//
//class QrCodeGenerator{
//    func generatorQr() -> UIImage? {
//        let data = string.data(using: String.Encoding.ascii)
//
//            if let filter = CIFilter(name: "CIQRCodeGenerator") {
//                filter.setValue(data, forKey: "inputMessage")
//                let transform = CGAffineTransform(scaleX: 3, y: 3)
//
//                if let output = filter.outputImage?.transformed(by: transform) {
//                    return UIImage(ciImage: output)
//                }
//            }
//
//            return nil
//    }
//}
