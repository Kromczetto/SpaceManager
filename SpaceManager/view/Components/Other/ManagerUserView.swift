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
    @State var selectedOption: String = ""
    @State private var isEdit: Bool = false
    @EnvironmentObject var managerViewModel: ManagerViewModel
    @EnvironmentObject var favouriteItemViewModel: FavouriteItemViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            if isEdit {
                List {
                    Text("Uid: \(uid)")
                    Text("Email: \(email)")
                    Picker("Uprawnienie:", selection: $selectedOption) {
                        Text("Adder").tag("Adder")
                        Text("Reader").tag("Reader")
                        Text("Admin").tag("Admin")
                        Text("Full").tag("Full")
                    }
                    VStack {
                        BtnModifier(btnText: "Zapisz",
                                    btnIcon: "paperplane",
                                    btnColor: .green,
                                    width: 250) {
                            isEdit = !isEdit
                        }.padding(.horizontal)
                    }.padding(.horizontal)
                    .onChange(of: selectedOption) {
                        managerViewModel.updateUser(uid: uid,
                                                    email: email,
                                                    permission: Permission(rawValue: selectedOption)!
                        )
                        permission = Permission(rawValue: selectedOption)!
                    }
                }.onAppear {
                    managerViewModel.getItems(uid: uid)
                }
            } else {
                List {
                    Text("Uid: \(uid)")
                    Text("Email: \(email)")
                    Text("Uprawnienia: \(permission)")
                    HStack {
                        BtnModifier(btnText: "Zmień uprawnienia",
                                    btnIcon: "pencil",
                                    btnColor: .blue,
                                    width: 250) {
                            isEdit = !isEdit
                        }
                        .padding(.horizontal)
                    }.padding(.horizontal)
                    HStack {
                        BtnModifier(btnText: "Usuń użytkownika",
                                    btnIcon: "trash",
                                    btnColor: .red,
                                    width: 250) {
                            managerViewModel.deleteUser(uid: uid)
                            dismiss()
                        }.padding(.horizontal)
                        
                    }.padding(.horizontal)
                }.onAppear {
                    managerViewModel.getItems(uid: uid)
                    print("UID: \(uid)")
                }
            }
            
            Spacer()
        }
        if !managerViewModel.items.isEmpty {
            List {
                ForEach(managerViewModel.items, id: \.id) { item in
                    HStack {
                        Text("\(item.name)")
                        NavigationLink(destination:
                                        ReadItemView(messageFromQR: item.id,
                                                    adminChange: true,
                                                    uidFromAdmin: uid)
                                            .navigationBarBackButtonHidden(true)
                                            .environmentObject(favouriteItemViewModel)
                                            .navigationBarItems(leading: CustomBack(title:"Wróć"))) {
                            EmptyView()
                        }
                    }
                }
            }
        } else {
            List {
                Text("Użytkownik nie posiada żadnych przedmiotów")
                    .foregroundStyle(.orange)
            }
            
        }
        Spacer()
    }
}

#Preview {
    ManagerUserView()
}
