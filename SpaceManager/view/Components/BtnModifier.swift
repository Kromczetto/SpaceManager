//
//  BtnModifier.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 04/07/2024.
//

import SwiftUI

struct BtnModifier: View {
    
    var btnText: String
    var btnIcon: String
    var btnColor: Color = .blue
    var action: ()-> Void
    var body: some View {
        Button{
            action()
        } label:{
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(btnColor)
                    .padding(10)
                    .frame(width: 150, height: 50)
                Text("\(btnText) \(Image(systemName: btnIcon))")
                    .foregroundStyle(.white)
                    .padding()
                    .bold()
                    .font(.system(size: 16))
            }
        }
    }
}

//#Preview {
//    BtnModifier()
//}
