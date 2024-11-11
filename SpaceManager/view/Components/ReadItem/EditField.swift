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
    @Binding var isEdit: Bool
    @EnvironmentObject var readItemViewModel: ReadItemViewModel
    @EnvironmentObject var favouriteItemViewModel: FavouriteItemViewModel
    @StateObject private var validItem = AddNewItemViewModel()
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
                                    changeUid: changeUid)
                        } else {
                            readItemViewModel.saveNewData(idOfItem: messageFromQR, 
                                    nameOfItem: $itemName.wrappedValue,
                                    amountOfItem: $amount.wrappedValue,
                                    weigthOfItem: $weight.wrappedValue,
                                    commentsToItem: $comment.wrappedValue)
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
