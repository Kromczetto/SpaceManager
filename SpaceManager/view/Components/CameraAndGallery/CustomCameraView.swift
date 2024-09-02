//
//  CustomCameraView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 17/07/2024.
//

import SwiftUI

struct CustomCameraView: View {
    @State var isFront: Bool = true
    let cameraSeriveFront = CameraService(siteOfCamera: .front)
    let cameraSeriveBack = CameraService(siteOfCamera: .back)
    @Binding var captureImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            CameraView(cameraService: isFront  ? cameraSeriveFront : cameraSeriveBack) { result in
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
                    isFront ? cameraSeriveFront.capturePhoto() : cameraSeriveBack.capturePhoto()
                } label: {
                    Image(systemName: "circle")
                        .font(.system(size: 72))
                }
            }
        }
    }
}


