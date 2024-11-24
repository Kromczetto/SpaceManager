//
//  StatsView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 14/10/2024.
//

import SwiftUI
import Charts
struct StatsView: View {
    @State var itemStats: Bool = false
    @State var itemChart: Bool = false
    @EnvironmentObject var statsViewModel: StatsViewModel
    var body: some View {
        if let stats = statsViewModel.stats {
            List {
                Text("Liczba dodanych przez Ciebie przedmiotów: **\(stats.numberOfAddedItem)**")
                Text("Liczba odczytanych przez Ciebie przedmiotów: **\(stats.numberOfReadItem)**")
                HStack {
                    Spacer()
                    SettingsBtn(labelBtn: "Pokaż statystki przedmiotów",
                                colorBtn: .white,
                                bg: .gray) {
                        itemStats.toggle()
                    }
                    Spacer()
                }
                .onAppear {
                    statsViewModel.reverseIdToName()
                }
                if itemStats {
                    ForEach(statsViewModel.itemStat) { s in
                        Text("\(s.itemName): **\(s.numberOfRead)**")
                    }
                }
//                HStack {
//                    Spacer()
//                    SettingsBtn(labelBtn: "Pokaż statystki na wykresie",
//                                colorBtn: .white,
//                                bg: .gray) {
//                        itemChart.toggle()
//                    }
//                    NavigationLink(destination: ChartView().navigationBarBackButtonHidden(true)
//                                      .environmentObject(statsViewModel)
//                                      .navigationBarItems(leading: CustomBack(title:"Wróć")),
//                                   isActive: $itemChart) {
//                        EmptyView()
//                    }
//                    Spacer()
//                }
                SettingsBtn(labelBtn: "Zmień hasło", colorBtn: .black) {
                    itemChart = true
                }
                NavigationLink(destination: ChartView()
                                                .environmentObject(statsViewModel)
                                                .navigationBarBackButtonHidden(true)
                                                .navigationBarItems(leading: CustomBack(title:"Wróć")),
                                                isActive: $itemChart) {
                                                    EmptyView()
                }
            }
            
        } else {
            Text("Wystąpił błąd podczas łądowania statystyk")
                .foregroundStyle(.orange)
        }
    }
}

#Preview {
    StatsView()
}
