//
//  ProfileView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 16/05/2024.
//

import SwiftUI


struct ProfileView: View {
    @StateObject var profileViewModel = ProfileViewModel()
    @State private var showCamera = false
    @State private var selectedImage: UIImage?
    @State var image: UIImage?
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(Color(red: 80/255, green: 80/255, blue: 80/255))
                    .padding(10)
                    .frame(width: 420, height: 120)
                HStack() {
                    Button{
                        self.showCamera.toggle()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 100)
                                .foregroundColor(Color(red: 220/255, green: 220/255, blue: 220/255))
                                .frame(width: 80, height: 80)
                            Image(systemName: "plus")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                        }
                    } .fullScreenCover(isPresented: self.$showCamera) {
                        accessCameraView(selectedImage: self.$selectedImage)
                    }
                    Text(profileViewModel.whoAmI())
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(width: 280, height: 20)
                        .font(.system(size: 20))
                }
            }
            Spacer()
            BtnProfile()
        }
    }
}

struct accessCameraView: UIViewControllerRepresentable {
    
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
#Preview {
    ProfileView()
}
