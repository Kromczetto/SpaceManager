//
//  BtnMenu.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 04/05/2024.
//

import SwiftUI

struct BtnMenu: View {
    var btnText: String
    var btnIcon: String
    var destinationView: AnyView
    
    @State var isActive: Bool = true
    var body: some View {
        NavigationLink {
            destinationView
        } label: {
            ZStack {
                Text("\(Image(systemName: btnIcon)) \(btnText)")
            }
        }.disabled(isActive)
       
    }
}


