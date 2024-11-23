//
//  ChartView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 13/11/2024.
//

import SwiftUI
import Charts
struct ChartView: View {
    @EnvironmentObject var statsViewModel: StatsViewModel
    var body: some View {
        Chart(statsViewModel.itemStat) { s in
            SectorMark(
                angle: .value(
                    Text(verbatim: s.itemName),
                    s.numberOfRead
                ),
                innerRadius: .ratio(0.6)
            )
            .foregroundStyle(
                by: .value(
                    Text(verbatim: s.itemName),
                    s.itemName
                )
            )
        }
        .padding(50)
        .scaleEffect(1.1)
    }
}

