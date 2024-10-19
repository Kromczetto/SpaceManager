//
//  HeartButton.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 10/10/2024.
//

import SwiftUI

struct HeartButton: View {
    @Binding var isClick: Bool
    var body: some View {
    Image(systemName: isClick ? "heart.fill" : "heart")
        .resizable()
        .frame(width: 25.0, height: 22.0)
        .padding()
        .onTapGesture {
            isClick = !isClick
        }
    }
}


