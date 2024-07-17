//
//  ProfileView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 16/05/2024.
//

import SwiftUI


struct ProfileView: View {
    @StateObject var profileViewModel = ProfileViewModel()
    @State private var showCamera: Bool = false
    @State private var captureImage: UIImage? = nil
//    @State var image: UIImage?
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(Color(red: 80/255, green: 80/255, blue: 80/255))
                    .padding(10)
                    .frame(width: 420, height: 120)
                HStack() {
                    Button {
                        self.showCamera.toggle()
                    } label: {
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
                    } .sheet(isPresented: self.$showCamera, content: {
                        CustomCameraView(captureImage: $captureImage)
                    })
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

#Preview {
    ProfileView()
}
