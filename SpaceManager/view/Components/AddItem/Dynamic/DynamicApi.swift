//
//  DynamicApi.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 03/09/2024.
//

import SwiftUI

struct DynamicApi: View {
    @State var itemID: String = ""
    @EnvironmentObject var dynamicItemViewModel: DynamicItemViewModel
    @EnvironmentObject var apiManagerViewModel: ApiManagerViewModel
    @StateObject var addActiveItemViewModel = AddActiveItemViewModel()
    @State var apiURL: String = ""
    var body: some View {
        TextField("Podaj link do api", text: $apiURL)
        Button {
            addActiveItemViewModel.addNewActiveItem(itemID: itemID, apiURL: apiURL)
            print(apiURL)
        } label: {
            Text("Klik")
        }
    }
}

#Preview {
    DynamicApi()
}
