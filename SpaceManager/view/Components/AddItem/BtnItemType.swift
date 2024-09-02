//
//  BtnItemType.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 04/07/2024.
//

import SwiftUI

struct BtnItemType: View {
    @EnvironmentObject var generatorViewModel: GeneratorViewModel
    var btnText: String = "Statyczne"
    var firstColor: Color = .blue
    var secondColor: Color = .gray
    @State var state: Bool = true
    var action: ()->Void
    
    var body: some View {
        Button {
          action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(generatorViewModel.isStatic ? firstColor : secondColor)
                    .frame(width: 100, height: 30)
                Text(btnText)
                    .foregroundStyle(.white)
                    .padding()
                    .bold()
                    .font(.system(size: 16))
            }
        }.padding(.leading, -3)
    }
}

//#Preview {
//    BtnItemType()
//}
