//
//  EditField.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 29/08/2024.
//

import SwiftUI

struct EditField: View {
    var messageFromQR: String
    
    @State var itemName: String = ""
    @State var amount: String = ""
    @State var weight: String = ""
    @State var comment: String = ""
    
    @Binding var isEdit: Bool
    @EnvironmentObject var readItemViewModel: ReadItemViewModel
    
    var body: some View {
        List {
            VStack {
                HStack {
                    Text("Nazwa:")
                    TextField("Nazwa", text: $itemName)
//                        .onAppear {
//                            self.itemName = item.name
//                        }
                }
                HStack {
                    Text("Ilość:")
                    TextField("Ilość", text: $amount)
//                        .onAppear {
//                            self.amount = item.amount
//                        }
                }
                HStack {
                    Text("Waga:")
                    TextField("Waga", text: $weight)
//                        .onAppear {
//                            self.weight = item.productWeight
//                        }
                }
                HStack {
                    Text("Uwagi:")
                    TextField("Uwagi", text: $comment)
//                        .onAppear {
//                            self.comment = item.commentsToItem
//                        }
                }
                
                ForEach(0 ..< readItemViewModel.item!.properties.count) { index in
                    HStack {
                        TextField("\(readItemViewModel.tempKeys[index])",
                                  text: $readItemViewModel.tempKeys[index])
                        Text(":")
                        TextField("\(readItemViewModel.tempValues[index])",
                                  text: $readItemViewModel.tempValues[index])
                    }
                }
            }
        }
        HStack {
            BtnModifier(btnText: "Zapisz", btnIcon: "paperplane",
                        btnColor: .green) {
                readItemViewModel.saveNewData(idOfItem: messageFromQR, nameOfItem: $itemName.wrappedValue,
                                              amountOfItem: $amount.wrappedValue, weigthOfItem: $weight.wrappedValue, commentsToItem: $comment.wrappedValue)
                isEdit = !isEdit
            }
            BtnModifier(btnText: "Wróć", btnIcon: "arrowshape.turn.up.backward") {
                isEdit = !isEdit
            }
        }
    }
}
