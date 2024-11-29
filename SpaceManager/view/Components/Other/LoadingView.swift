//
//  LoadingView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 26/11/2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                .scaleEffect(2)
        }
    }
}

#Preview {
    LoadingView()
}
