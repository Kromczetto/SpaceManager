//
//  BasicForm.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 03/09/2024.
//

import SwiftUI

struct BasicForm: View {
    @Binding var itemName: String
    @Binding var numberOfItems: String
    @Binding var weight: String
    @Binding var comments: String
    
    var body: some View {
        TextField("Nazwa", text: $itemName)
        TextField("Ilość", text: $numberOfItems)
        TextField("Waga", text: $weight)
        TextField("Uwagi", text: $comments)
    }
}

