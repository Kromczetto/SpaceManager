//
//  PhotoPicker.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 18/07/2024.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: View {
    @State private var captureImage: UIImage? = nil
    @State private var selectedItem: PhotosPickerItem?
    var body: some View {
        PhotosPicker("Select an image", selection: $selectedItem, matching: .images)
            .onChange(of: selectedItem) {
                Task {
                    if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                        captureImage = UIImage(data: data)
                    }
                    print("Failed to load the image")
                }
            }
    }
}

#Preview {
    PhotoPicker()
}
