//
//  BottomMenu.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 04/05/2024.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct BottomMenu: View {
    
    @StateObject var logManager = MainViewModel()

//    @StateObject private var cameraViewModel = CameraViewModel()
    var body: some View {
        HStack{
            Group{
                
            Spacer()
            BtnMenu(btnText: "Dodaj", btnIcon: "plus.app.fill",destinationView: AnyView(LoggedMainView().navigationBarBackButtonHidden(true)))
            Spacer()
            BtnMenu(btnText: "Szukaj", btnIcon: "magnifyingglass",destinationView: AnyView(SearchView().navigationBarBackButtonHidden(true)))
            Spacer()
            BtnMenu(btnText: "Profil", btnIcon: "person.crop.circle.fill",destinationView: AnyView(ProfileView().navigationBarBackButtonHidden(true)))
            Spacer()
          
        }.padding(.bottom, 30)
            .font(.system(size: 20))
        }
    }
}

#Preview {
    BottomMenu()
}
