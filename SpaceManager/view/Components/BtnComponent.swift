//
//  BtnComponent.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 10/04/2024.
//

import Foundation
import SwiftUI

struct BtnComponent: View {
    
    var btnTextColor: Color
    var btnText: String
    var btnTextSize: CGFloat
 
    
    var body: some View{
        Button{
            
        } label:{
            
            Text(btnText)
                .foregroundStyle(btnTextColor)
                .font(.system(size: btnTextSize))
                .underline()
        }
        
    }
}
