//
//  CheckboxNumberOfSpins.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 03/07/2024.
//

import SwiftUI

struct CheckboxNumberOfSpins: View {
    @Binding var isChecked: Bool
    @State var CheckName: String = ""
    var body: some View {
        Button {
            self.isChecked.toggle()
        } label: {
            HStack{
                Image(systemName: isChecked ? "checkmark.square" : "square")
                                    .foregroundColor(isChecked ? .green : .gray)
                Text(CheckName)
                    .foregroundColor(.gray)
            }
        }
    }
}



#Preview {
    CheckboxNumberOfSpins()
}
