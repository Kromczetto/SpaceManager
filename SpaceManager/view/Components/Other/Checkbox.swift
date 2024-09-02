//
//  Checkbox.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 02/07/2024.
//

import SwiftUI

struct Checkbox: View {
    @Binding var isChecked: Bool
    var checkName: String = ""
//    var activeHandler: ActivevHandlerViewModel
    var body: some View {
        Button {
            self.isChecked.toggle()
        } label: {
            HStack {
                Image(systemName: isChecked ? "checkmark.square" : "square")
                                    .foregroundColor(isChecked ? .green : .gray)
                Text(checkName)
                    .foregroundColor(.gray)
            }
        }
    }
}


