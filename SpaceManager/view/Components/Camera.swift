//
//  Camera.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 17/07/2024.
//

import SwiftUI


struct Camera: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
 
    @Environment(\.presentationMode) var isPresented
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

//#Preview {
//    Camera()
//}
