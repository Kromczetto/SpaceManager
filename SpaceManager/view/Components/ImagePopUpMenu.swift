//
//  ImagePopUpMenu.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 18/07/2024.
//

import SwiftUI
import PhotosUI

struct ImagePopUpMenu: View {
    var labelText: String = ""
    var isFront: Bool = true
    
    @State private var showCamera: Bool = false
    @State private var showPhotoPicker: Bool = false
    @State private var captureImage: UIImage? = nil
    @State private var selectedItem: PhotosPickerItem?
    
    var body: some View {
      
        Menu {
            Button {
                self.showCamera.toggle()
            } label: {
                Text("Zrób zdjęcie")
            }
            Button {
                self.showPhotoPicker.toggle()
            } label : {
                Text("Wybierz z galerii")
            }
            Button(role: .destructive) {
                print("anuluj")
            } label: {
                Text("Anuluj")
            }
        } label: {
            if (!isFront && labelText != "") {
                Text(labelText)
            }
            else {
                ZStack {
                    RoundedRectangle(cornerRadius: 100)
                        .foregroundColor(Color(red: 220/255, green: 220/255, blue: 220/255))
                        .frame(width: 80, height: 80)
                    if let image = captureImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "plus")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                    }
                }
            }
        }.sheet(isPresented: self.$showCamera, content: {
            CustomCameraView(isFront: isFront, captureImage: $captureImage)
        })
        .photosPicker(isPresented: self.$showPhotoPicker, selection: $selectedItem, matching: .images)
               .onChange(of: selectedItem) { newItem in
                   Task {
                       if let data = try? await newItem?.loadTransferable(type: Data.self) {
                           captureImage = UIImage(data: data)
                       } else {
                           print("Failed to load the image")
                       }
                   }
               }
    }
}

#Preview {
    ImagePopUpMenu()
}
