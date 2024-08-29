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
    @Binding var isEdit: Bool
    @EnvironmentObject var readItemViewModel: ReadItemViewModel
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
                DispatchQueue.main.async {
                    readItemViewModel.saveNewData(idOfItem: messageFromQR, nameOfItem: $itemName.wrappedValue,
                                                  amountOfItem: $amount.wrappedValue, weigthOfItem: $weight.wrappedValue,
                                                  commentsToItem: $comment.wrappedValue)
                    isEdit = !isEdit
                }
            }
            BtnModifier(btnText: "Wróć", btnIcon: "arrowshape.turn.up.backward") {
                isEdit = !isEdit
            }
        }
    }
}
