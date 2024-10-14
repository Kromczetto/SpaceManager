//
//  FavouriteView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 14/10/2024.
//

import SwiftUI

struct FavouriteView: View {
    @EnvironmentObject var favouriteItemViewModel : FavouriteItemViewModel
    var body: some View {
        List {
            ForEach(Array($favouriteItemViewModel.arrayOfFavourtieItem.enumerated()) , id: \.offset) { index, _ in
                Text(favouriteItemViewModel.arrayOfFavourtieItem[index])
            }
                    
        }.onAppear {
            favouriteItemViewModel.arrayOfFavourtieItem.removeAll()
            favouriteItemViewModel.getFavouriteItems()
        }
    }
}

#Preview {
    FavouriteView()
}
