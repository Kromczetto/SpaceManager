//
//  BtnDatabase.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 20/06/2024.
//

import SwiftUI

struct BtnDatabase: View {
    @State var btnLabel = "Button"
    var action: () -> Void
    
    var body: some View {
        
        Button{
            action()
        } label:{
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.blue)
                    .padding(10)
                    .frame(width: 350, height: 80)
                Text(btnLabel)
                    .foregroundStyle(.white)
                    .padding()
                    .bold()
                    .font(.system(size: 16))
            }
        }
    }
}

#Preview {
    BtnDatabase(){print(" ")}
}
