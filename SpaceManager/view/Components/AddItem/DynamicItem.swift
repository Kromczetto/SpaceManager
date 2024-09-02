//
//  DynamicItem.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 29/08/2024.
//

import SwiftUI

struct DynamicItem: View {
    @State var productID: String
    @EnvironmentObject var dynamicItemViewModel: DynamicItemViewModel
    var body: some View {
        //StaticItem().frame(height: 400)
        List {
            Text("asd")
            ForEach(Array($dynamicItemViewModel.api.enumerated()), id: \.offset) { index, _ in
                HStack {
                    TextField("Źródło:", text: $dynamicItemViewModel.apiConnection[index])
                    TextField("Wartość", text: $dynamicItemViewModel.valueName[index])
                }.onAppear {
                    print(dynamicItemViewModel.apiConnection)
                    print(dynamicItemViewModel.valueName)
                }
            }.onDelete(perform: dynamicItemViewModel.removeItems)
        }
        Button {
            dynamicItemViewModel.createApiConnection()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.red)
                    .padding(10)
                    .frame(width: 350, height: 80)
                Text("+")
                    .foregroundStyle(.white)
                    .padding()
                    .bold()
                    .font(.system(size: 16))
            }
        }.disabled(dynamicItemViewModel.canAddNewApi())
    }
}

#Preview {
    DynamicItem(productID: "ID")
}
