//
//  DynamicApi.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 03/09/2024.
//

import SwiftUI

struct DynamicApi: View {
    @EnvironmentObject var dynamicItemViewModel: DynamicItemViewModel
    var body: some View {
        List {
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
                Text("Dodaj aktywne pole")
                    .foregroundStyle(.white)
                    .padding()
                    .bold()
                    .font(.system(size: 16))
            }
        }.disabled(dynamicItemViewModel.canAddNewApi())
    }
}

#Preview {
    DynamicApi()
}