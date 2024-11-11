//
//  FavouriteView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 14/10/2024.
//

import SwiftUI
import FirebaseAuth
struct FavouriteView: View {
    @State var isEdit: Bool = false
    @State var adminChange: Bool = false
    @State var uidFromAdmin: String = ""
    @State var readItemViewModel = ReadItemViewModel()
    @EnvironmentObject var favouriteItemViewModel : FavouriteItemViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        List {
            if $favouriteItemViewModel.arrayOfFavourtieItem.isEmpty {
                Text("Nie masz ulubionych przedmiotów")
                    .foregroundStyle(.orange)
            }
            ForEach(Array($favouriteItemViewModel.arrayOfFavourtieItem.enumerated()) , id: \.offset) { index, _ in
                HStack {
                    Text(favouriteItemViewModel.arrayOfFavourtieItem[index])
                    NavigationLink(destination:
                                    ReadItemView(messageFromQR: favouriteItemViewModel.arrayOfFid[index],
                                                 adminChange: true,
                                                 uidFromAdmin: Auth.auth().currentUser!.uid)
                                        .navigationBarBackButtonHidden(true)
                                        .environmentObject(favouriteItemViewModel)
                                        .navigationBarItems(leading: CustomBack(title:"Wróć"))) {
                                            EmptyView()
                                        }
                }
                
            }
        }
    }
}
//#Preview {
//    FavouriteView()
//}
