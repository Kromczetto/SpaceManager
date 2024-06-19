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
    
    //zmienic zeby bylo przekazywane jako properties
    @StateObject var logManager = MainViewModel()
    var body: some View {
        HStack{
            Group{
                
            Spacer()
            BtnMenu(btnText: "Dodaj", btnIcon: "plus.app.fill",destinationView: AnyView(LoggedMainView()))
            Spacer()
            BtnMenu(btnText: "Szukaj", btnIcon: "magnifyingglass",destinationView: AnyView(SearchView()))
            Spacer()

            BtnMenu(btnText: "Profil", btnIcon: "person.crop.circle.fill",destinationView: AnyView(ProfileView()))
//                {
//                do{
//                    try Auth.auth().signOut()
//                    logManager.logged = false
//                }catch{
//                    print("Problem with siging out")
//                }
//                
//                
//            }
            Spacer()
          
        }.padding(.bottom, 30)
            .font(.system(size: 20))
        }
    }
}

#Preview {
    BottomMenu()
}
