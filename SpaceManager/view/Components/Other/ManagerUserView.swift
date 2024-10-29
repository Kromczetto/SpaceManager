//
//  ManagerUserView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 29/10/2024.
//

import SwiftUI

struct ManagerUserView: View {
    @State var email: String = ""
    @State var uid: String = ""
    @State var permission: Permission = .Adder
    @State private var isEdit: Bool = false
    @EnvironmentObject var managerViewModel: ManagerViewModel
    @EnvironmentObject var favouriteItemViewModel: FavouriteItemViewModel
    var body: some View {
        VStack {
            if isEdit {
                List {
                    Text("IN PROGRES")
                }.onAppear {
                    managerViewModel.getItems(uid: uid)
                }
            } else {
                List {
                    Text("Uid: \(uid)")
                    Text("Email: \(email)")
                    Text("Uprawnienia: \(permission)")
                }.onAppear {
                    managerViewModel.getItems(uid: uid)
                    print("UID: \(uid)")
                }
            }
            Button {
                isEdit = !isEdit
            } label: {
                Text("Edit")
            }
        }
        if !managerViewModel.items.isEmpty {
            List {
                ForEach(managerViewModel.items, id: \.id) { item in
                    HStack {
                        Text("\(item.name)")
                        NavigationLink(destination:
                                        ReadItemView(messageFromQR: item.id)
                                            .navigationBarBackButtonHidden(true)
                                            .environmentObject(favouriteItemViewModel)
                                            .navigationBarItems(leading: CustomBack(title:"Wróć"))) {
                            EmptyView()
                        }
                    }
                }
            }
        } else {
            Text("Użytkownik nie posiada żadnych przedmiotów")
        }
    }
}

#Preview {
    ManagerUserView()
}
