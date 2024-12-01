//
//  EditField.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 29/08/2024.
//

import SwiftUI

struct EditField: View {
    var messageFromQR: String = ""
    @State var itemName: String = ""
    @State var amount: String = ""
    @State var weight: String = ""
    @State var comment: String = ""
    @State var alert: Bool = false
    @State var adminChange: Bool = false
    @State var changeUid: String = ""
    @State var parm1: String = ""
    @State var parm2: String = ""
    @State var parm3: String = ""
    @State var parm4: String = ""
    @Binding var isEdit: Bool
    @EnvironmentObject var readItemViewModel: ReadItemViewModel
    @EnvironmentObject var readActiveItemViewModel: ReadActiveViewModel
    @EnvironmentObject var favouriteItemViewModel: FavouriteItemViewModel
    @StateObject private var validItem = AddNewItemViewModel()
    @StateObject private var addActive = AddActiveItemViewModel()
    var body: some View {
        if let item = readItemViewModel.item {
            List {
                VStack {
                    HStack {
                        Text("Nazwa:")
                        TextField("Nazwa", text: $itemName)
                    }
                    HStack {
                        Text("Ilość:")
                        TextField("Ilość", text: $amount)
                    }
                    HStack {
                        Text("Waga:")
                        TextField("Waga", text: $weight)
                    }
                    HStack {
                        Text("Uwagi:")
                        TextField("Uwagi", text: $comment)
                    }
                    ForEach(0 ..< readItemViewModel.item!.properties.count) { index in
                        HStack {
                            TextField("\(readItemViewModel.tempKeys[index])", text: $readItemViewModel.tempKeys[index])
                            Text(":")
                            TextField("\(readItemViewModel.tempValues[index])",
                                      text: $readItemViewModel.tempValues[index])
                        }
                    }
                    if let it = readActiveItemViewModel.activeItem {
                        TextField("\(it.parm1)", text: $parm1)
                            .onAppear {
                                parm1 = it.parm1
                            }
                        TextField("\(it.parm2)", text: $parm2)
                            .onAppear {
                                parm2 = it.parm2
                            }
                        TextField("\(it.parm3)", text: $parm3)
                            .onAppear {
                                parm3 = it.parm3
                            }
                        TextField("\(it.parm4)", text: $parm4)
                            .onAppear {
                                parm4 = it.parm4
                            }
                    }
                }
            }
        }
        HStack {
            BtnModifier(btnText: "Zapisz", btnIcon: "paperplane",
                        btnColor: .green) {
                validItem.itemName = $itemName.wrappedValue
                validItem.numberOfItems = $amount.wrappedValue
                validItem.weight = $weight.wrappedValue
                validItem.comments = $comment.wrappedValue
                if validItem.validItemField() {
                    DispatchQueue.main.async {
                        if adminChange {
                            readItemViewModel.saveNewDataFromAdmin(idOfItem: messageFromQR, 
                                    nameOfItem: $itemName.wrappedValue,
                                    amountOfItem: $amount.wrappedValue,
                                    weigthOfItem: $weight.wrappedValue,
                                    commentsToItem: $comment.wrappedValue,
                                    changeUid: changeUid,
                                    did: readItemViewModel.item?.did)
                            addActive.updateActiveItem(id: messageFromQR,
                                                       item: readActiveItemViewModel.activeItem,
                                                       parm1: parm1,
                                                       parm2: parm2,
                                                       parm3: parm3,
                                                       parm4: parm4)
                        } else {
                            readItemViewModel.saveNewData(idOfItem: messageFromQR, 
                                    nameOfItem: $itemName.wrappedValue,
                                    amountOfItem: $amount.wrappedValue,
                                    weigthOfItem: $weight.wrappedValue,
                                    commentsToItem: $comment.wrappedValue,
                                    did: readItemViewModel.item?.did)
                            addActive.updateActiveItem(id: messageFromQR,
                                                       item: readActiveItemViewModel.activeItem,
                                                       parm1: parm1,
                                                       parm2: parm2,
                                                       parm3: parm3,
                                                       parm4: parm4)
                        }
                        favouriteItemViewModel.setFavouriteItem(newFavourite: $itemName.wrappedValue, itemID: messageFromQR)
                        favouriteItemViewModel.getFavouriteItems()
                        isEdit = !isEdit
                    }
                } else {
                    alert = true
                }
                
            }.alert("\($validItem.message.wrappedValue)",
                    isPresented: $alert) {
                             Button("OK", role: .cancel) {}
            }
            BtnModifier(btnText: "Wróć", btnIcon: "arrowshape.turn.up.backward") {
                isEdit = !isEdit
            }
        }
    }
}
