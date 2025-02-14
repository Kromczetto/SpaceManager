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
                Spacer()
                SettingsBtn(labelBtn: "Pokaż statystki przedmiotów",
                            colorBtn: .white,
                            bg: .gray) {
                    itemStats.toggle()
                }
                .onAppear {
                    statsViewModel.reverseIdToName()
                }
                if itemStats {
                    ForEach(statsViewModel.itemStat) { s in
                        Text("\(s.itemName): **\(s.numberOfRead)**")
                    }
                }
            }
            
        } else {
            Text("Wystąpił błąd podczas łądowania statystyk")
                .foregroundStyle(.orange)
        }
        SettingsBtn(labelBtn: "Pokaż statystki na wykresie", colorBtn: .white, bg: .gray) {
            itemChart.toggle()
        }
        NavigationLink(destination: ChartView().navigationBarBackButtonHidden(true)
                          .environmentObject(statsViewModel)
                          .navigationBarItems(leading: CustomBack(title:"Wróć")),
                       isActive: $itemChart) {
            EmptyView()
        }
    }
}

#Preview {
    StatsView()
}
