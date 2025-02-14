//
//  MuchProperties.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 24/08/2024.
//

import SwiftUI
struct CustomProperties: View {
    @EnvironmentObject var addNewItemViewModel: AddNewItemViewModel
    @EnvironmentObject var templateViewModel: TemplateViewModel
    @Binding var isCustomProperty: Bool
    @Binding var secondIteration: Bool 
    var body: some View {
        if isCustomProperty {
            List {
                ForEach(Array($addNewItemViewModel.propertyKey.enumerated()), id: \.offset) { index, _ in
                    HStack {
                        TextField("Właściość:", text: $addNewItemViewModel.propertyKey[index])
                        TextField("Wartość", text: $addNewItemViewModel.propertyValue[index])
                    }.onAppear { print("\(index)") }
                }.onDelete(perform: addNewItemViewModel.removeItems)
            }
        }
        Button {
            isCustomProperty = true
            DispatchQueue.main.async() {
                if secondIteration {
                    addNewItemViewModel.propertyKey.append("")
                    addNewItemViewModel.propertyValue.append("")
                }
                secondIteration = true                
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.blue)
                    .padding(10)
                    .frame(width: 350, height: 80)
                Text("Dodaj statyczne pole")
                    .foregroundStyle(.white)
                    .padding()
                    .bold()
                    .font(.system(size: 16))
            }
        }//.disabled(secondIteration ? addNewItemViewModel.canAddNewProperty() : false)
    }
}
