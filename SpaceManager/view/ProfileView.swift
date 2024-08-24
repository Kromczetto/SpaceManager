//
//  ProfileView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 16/05/2024.
//

import SwiftUI


struct ProfileView: View {
    @EnvironmentObject var profileViewModel : ProfileViewModel

    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(Color(red: 80/255, green: 80/255, blue: 80/255))
                    .padding(10)
                    .frame(width: 420, height: 120)
                HStack() {
                    ImagePopUpMenu(isFront: true)
                    Text(profileViewModel.userEmail)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(width: 280, height: 20)
                        .font(.system(size: 20))
                        .onAppear {
                            profileViewModel.whoAmI()
                        }
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
