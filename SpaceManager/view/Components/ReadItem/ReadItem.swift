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
    @State private var isFirstClick: Bool = false
    @EnvironmentObject var readItemViewModel: ReadItemViewModel
    @EnvironmentObject var readActiveViewModel: ReadActiveViewModel
    @EnvironmentObject var generatorViewModel: GeneratorViewModel
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
                        
                            
                    }
                }
            }
            HeartButton(isClick: $isClick)
                .onChange(of: isClick) {
                    if isClick {
                        print("Clicked")
                        favouriteItemViewModel.setFavouriteItem(newFavourite: readItemViewModel.item!.name,
                                                                itemID: readItemViewModel.item!.id)
                    } else {
                        print("Unclicked")
                        favouriteItemViewModel.deleteFavouriteItem(itemID: readItemViewModel.item!.id) 
                    }
                    
                }
                .padding(.bottom)
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
            readItemViewModel.fetchItem(with: messageFromQR)
            //readActiveViewModel.fetchItem(with: messageFromQR)
        }
        HStack {
            BtnModifier(btnText: "Edytuj", btnIcon: "pencil") {
                isEdit = !isEdit
            }
            BtnModifier(btnText: "Usuń", btnIcon: "trash", btnColor: .red) {
                readItemViewModel.delete(id: messageFromQR)
            }
        }
    }
}

