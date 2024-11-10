//
//  ProfileView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 16/05/2024.
//

import SwiftUI


struct ProfileView: View {
    @EnvironmentObject var profileViewModel : ProfileViewModel
    @EnvironmentObject var favouriteItemViewModel : FavouriteItemViewModel
    @EnvironmentObject var staySignin: StaySigninViewModel
    @State var favouriteBool: Bool = false
    @State var statsBool: Bool = false
    @State var settingsBool: Bool = false
    var body: some View {
        VStack {
            ZStack {
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
            ProfileListBtn(name: "Ulubione przedmioty",tempBool: $favouriteBool)
            NavigationLink(destination: FavouriteView().navigationBarBackButtonHidden(true)
                               .environmentObject(favouriteItemViewModel)
                               .navigationBarItems(leading: CustomBack(title:"Wróć")),
                                isActive: $favouriteBool) {
                EmptyView()
            }.onAppear {
                favouriteItemViewModel.getFavouriteItems()
            }
            ProfileListBtn(name: "Statystki",tempBool: $statsBool)
            NavigationLink(destination: StatsView().navigationBarBackButtonHidden(true)
                              .environmentObject(favouriteItemViewModel)
                              .navigationBarItems(leading: CustomBack(title:"Wróć")),
                                isActive: $statsBool) {
                EmptyView()
            }
            ProfileListBtn(name: "Ustaiwnia",tempBool: $settingsBool)
            NavigationLink(destination: SettingsView().navigationBarBackButtonHidden(true)
                              .environmentObject(favouriteItemViewModel)
                              .navigationBarItems(leading: CustomBack(title:"Wróć")),
                           isActive: $settingsBool) {
                EmptyView()
            }
            Spacer()
            BtnProfile()
                .environmentObject(staySignin)
                .environmentObject(profileViewModel)
        }
    }
}

#Preview {
    ProfileView()
}
