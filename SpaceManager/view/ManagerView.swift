//
//  ManagerView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 15/07/2024.
//

import SwiftUI

struct ManagerView: View {
    @EnvironmentObject var managerViewModel: ManagerViewModel
    @EnvironmentObject var favouriteItemViewModel: FavouriteItemViewModel
    @State var searchingWord: String = ""
    var body: some View {
        VStack {
            TextField("Szukaj", text: $searchingWord)
                .padding()
                .onChange(of: searchingWord) {
                    managerViewModel.findEmail(email: searchingWord)
                }
            List {
                ForEach(managerViewModel.publicUsers, id: \.email) { user in
                    HStack {
                        Text("\(user.email)")
                        NavigationLink(destination:
                                        ManagerUserView(email: user.email,
                                                        uid: user.uid,
                                                        permission: user.permission)
                                            .navigationBarBackButtonHidden(true)
                                           .environmentObject(managerViewModel)
                                           .environmentObject(favouriteItemViewModel)
                                           .navigationBarItems(leading: CustomBack(title:"Wróć"))) {
                            EmptyView()
                        }
                    }
                }
            }
        }
    }
}
