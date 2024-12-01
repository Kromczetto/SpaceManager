//
//  LoadingItem.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 01/12/2024.
//

import SwiftUI

struct LoadingItem: View {
    var messageFromQR: String
    @Binding var isEdit: Bool
    @Binding var isClick: Bool
    @Binding var adminChange: Bool
    @Binding var uidFromAdmin: String
    @State private var isFirstClick: Bool = false
    @EnvironmentObject var readItemViewModel: ReadItemViewModel
    @EnvironmentObject var readActiveViewModel: ReadActiveViewModel
    @EnvironmentObject var favouriteItemViewModel: FavouriteItemViewModel
    @EnvironmentObject var statsViewModel: StatsViewModel
    @EnvironmentObject var apiManagerViewModel: ApiManagerViewModel
    var body: some View {
        if let readItem = readItemViewModel.item {
            if readItem.did == nil {
                ReadItem(messageFromQR: messageFromQR,
                         isEdit: $isEdit,
                         isClick: $favouriteItemViewModel.isOnList,
                         adminChange: $adminChange,
                         uidFromAdmin: $uidFromAdmin)
                .environmentObject(readItemViewModel)
                .environmentObject(readActiveViewModel)
                .environmentObject(favouriteItemViewModel)
                .environmentObject(statsViewModel)
                .environmentObject(apiManagerViewModel)
            } else {
                if apiManagerViewModel.recivedData {
                    ReadItem(messageFromQR: messageFromQR,
                             isEdit: $isEdit,
                             isClick: $favouriteItemViewModel.isOnList,
                             adminChange: $adminChange,
                             uidFromAdmin: $uidFromAdmin)
                    .environmentObject(readItemViewModel)
                    .environmentObject(readActiveViewModel)
                    .environmentObject(favouriteItemViewModel)
                    .environmentObject(statsViewModel)
                    .environmentObject(apiManagerViewModel)
                } else {
                    
                    LoadingView()
                }
            }
        } else {
            LoadingView()
        }
    }
}

