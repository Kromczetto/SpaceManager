//
//  ReadItem.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 29/08/2024.
//

import SwiftUI

struct ReadItem: View {
    var messageFromQR: String
    @Binding var isEdit: Bool
    @Binding var isClick: Bool
    @Binding var adminChange: Bool
    @Binding var uidFromAdmin: String
    @State private var isFirstClick: Bool = false
    @EnvironmentObject var readItemViewModel: ReadItemViewModel
    @EnvironmentObject var readActiveViewModel: ReadActiveViewModel
    //@EnvironmentObject var generatorViewModel: GeneratorViewModel
    @EnvironmentObject var favouriteItemViewModel: FavouriteItemViewModel
    var body: some View {
        VStack {
            List {
                if let item = readItemViewModel.item {
                    Text("Nazwa: \(item.name)")
                    Text("Ilość: \(item.amount)")
                    Text("Waga: \(item.productWeight)")
                    Text("Uwagi: \(item.commentsToItem)")
                    Text("Dodane przez: \(item.nameOfAdder)")
                    Text("Dodano: \(readItemViewModel.prepairDate(input: item.addDate))")
                    ForEach(0..<item.properties.count, id: \.self) { index in
                        let dict = item.properties[index]
                        ForEach(dict.keys.sorted(), id: \.self) { key in
                            if let value = dict[key] {
                                HStack {
                                    Text("\(key): \(value)")
                                }
                            }
                        }
                    }.onAppear {
                        readItemViewModel.splitProperties()
                        if !adminChange {
                            favouriteItemViewModel.isOnFavouriteList(id: messageFromQR)
                            isClick = favouriteItemViewModel.isOnList
                        }
                    }
                }
            }
//            Text("\(favouriteItemViewModel.arrayOfFavourtieItem)")
            if !adminChange {
                HeartButton(isClick: $isClick)
                    .onAppear {
                        favouriteItemViewModel.isOnFavouriteList(id: messageFromQR)
                        print("eee: \(favouriteItemViewModel.arrayOfFavourtieItem)")
                        if favouriteItemViewModel.isOnList {
                            isClick = true
                        } else {
                            isClick = false
                        }
                    }
                    .onChange(of: isClick) {
                        if isClick {
                            print("Clicked")
                            if let itemName = readItemViewModel.item?.name {
                                favouriteItemViewModel.setFavouriteItem(newFavourite: itemName,
                                                                        itemID: readItemViewModel.item!.id)
                            }
                        } else {
                            print("Unclicked")
                            if let itemID = readItemViewModel.item?.id {
                                
                                favouriteItemViewModel.deleteFavouriteItem(itemID: itemID)
                            }
                            
                        }
                        
                        
                    }
                    .padding(.bottom)
            }
//            if (generatorViewModel.num1 != 0) {
//                Text("Liczba obrotów: \(generatorViewModel.num1)")
//                    .onAppear {
//                    generatorViewModel.startGeneratingData()
//                    generatorViewModel.storeData(itemID: messageFromQR)
//                }
//                .onDisappear {
//                   generatorViewModel.stopGeneratingData()
//                }
//            }
//            if (generatorViewModel.num2 != 0) {
//                Text("Zużycie prądu: \(generatorViewModel.num2)")
//                    .onAppear {
//                    generatorViewModel.startGeneratingData()
//                    generatorViewModel.storeData(itemID: messageFromQR)
//                }
//                .onDisappear {
//                   generatorViewModel.stopGeneratingData()
//                }
//            }
//            if (generatorViewModel.workTime != 0) {
//                Text("Czas pracy: \(generatorViewModel.workTime)")
//                    .onAppear {
//                    generatorViewModel.startGeneratingData()
//                    generatorViewModel.storeData(itemID: messageFromQR)
//                }
//                .onDisappear {
//                   generatorViewModel.stopGeneratingData()
//                }
//            }
        }.onAppear {
            if adminChange {
                readItemViewModel.fetchItemAsAdmin(with: messageFromQR, uid: uidFromAdmin)
            } else {
                readItemViewModel.fetchItem(with: messageFromQR)
            }
            //readActiveViewModel.fetchItem(with: messageFromQR)
        }
        HStack {
            BtnModifier(btnText: "Edytuj", btnIcon: "pencil") {
                isEdit = !isEdit
            }
            BtnModifier(btnText: "Usuń", btnIcon: "trash", btnColor: .red) {
                if adminChange {
                    readItemViewModel.delete(id: messageFromQR, changeUid: uidFromAdmin)
                    favouriteItemViewModel.deleteFavouriteItem(itemID: messageFromQR)
                    favouriteItemViewModel.getFavouriteItems()
                    favouriteItemViewModel.isDeleting = true
                } else {
                    readItemViewModel.delete(id: messageFromQR)
                    favouriteItemViewModel.deleteFavouriteItem(itemID: messageFromQR)
                    favouriteItemViewModel.getFavouriteItems()
                    favouriteItemViewModel.isDeleting = true
                }
            }
        }
    }
}

