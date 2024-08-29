//
//  HeaderComponent.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 17/04/2024.
//

import Foundation
import SwiftUI

struct HeaderComponent: View {
    
    var headerText: String = "Header"
    var headerSize: CGFloat = 35
    var headerTopPadding: CGFloat = 200
    
    var body: some View{
        Text(headerText)
            .font(.system(size: headerSize))
            .padding(.top, headerTopPadding)
            .bold()
        
    }
}
