//
//  CustomCameraView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 17/07/2024.
//

import SwiftUI

struct CustomCameraView: View {
    
    let cameraSerive = CameraService()
    @Binding var captureImage: UIImage?
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            CameraView(cameraService: cameraSerive) { result in
                switch result {
                case .success(let photo):
                    if let data = photo.fileDataRepresentation() {
                        captureImage = UIImage(data: data)
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        print("No image found")
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
            VStack {
                Spacer()
                Button {
                    cameraSerive.capturePhoto()
                } label: {
                    Image(systemName: "circle")
                        .font(.system(size: 72))
                }
            }
        }
    }
}


