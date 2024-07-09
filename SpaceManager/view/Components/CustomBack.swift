//
//  CustomBack.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 08/07/2024.
//

import SwiftUI

struct CustomBack: View {
    @Environment(\.presentationMode) var presentationMode
    var title: String = "Wróć"
    
    var body: some View {
        Button{
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            HStack{
                Image(systemName: "chevron.left")
                Text(title)
            }
        }
    }
}

#Preview {
    CustomBack()
}
