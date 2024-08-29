//
//  MuchProperties.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 24/08/2024.
//

import SwiftUI

struct CustomProperties: View {
    @EnvironmentObject var addNewItemViewModel : AddNewItemViewModel
    @State private var isCustomProperty: Bool = false
    var body: some View {
        if isCustomProperty {
            List {
                ForEach(Array($addNewItemViewModel.properties.enumerated()), id: \.offset) { index, _ in
                
                    HStack{
                       
                    TextField("Właściość:", text: $addNewItemViewModel.propertyKey[index])
                    TextField("Wartość", text: $addNewItemViewModel.propertyValue[index])
                        
    
                    }.onAppear {
                        print(addNewItemViewModel.properties)
                        print("index of \(index)")
                    }
                }.onDelete(perform: addNewItemViewModel.removeItems)
            }
        }
        Button {
            isCustomProperty = true
            print(addNewItemViewModel.listIndex)
            addNewItemViewModel.createProperty()
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.blue)
                    .padding(10)
                    .frame(width: 350, height: 80)
                Text("+")
                    .foregroundStyle(.white)
                    .padding()
                    .bold()
                    .font(.system(size: 16))
            }
        }.disabled(addNewItemViewModel.canAddNewProperty())
    }
}

#Preview {
    CustomProperties()
}
