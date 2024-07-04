//
//  DisplayItem.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 04/07/2024.
//

import SwiftUI

struct DisplayItem: View {
    @StateObject var readItemViewModel = ReadItemViewModel()
    @StateObject var readActiveViewModel = ReadActiveViewModel()
    @EnvironmentObject var generatorViewModel: GeneratorViewModel
    var item: Item
    var idFromQR: String
    @Binding var isEdit: Bool
    
    var body: some View {
        List{
            Text("Nazwa: \(item.name)")
            Text("Ilość: \(item.amount)")
            Text("Waga: \(item.productWeight)")
            Text("Uwagi: \(item.commentsToItem)")
            Text("Dodane przez: \(item.nameOfAdder)")
            Text("Dodano: \(readItemViewModel.prepairDate(input: item.addDate))")
            
            if(generatorViewModel.num1 != 0){
                Text("Liczba obrotów: \(generatorViewModel.num1)").onAppear{
                    generatorViewModel.startGeneratingData()
                    generatorViewModel.storeData(itemID: idFromQR)
                }
                .onDisappear {
                   generatorViewModel.stopGeneratingData()
                }
            }
            if(generatorViewModel.num2 != 0){
                Text("Zużycie prądu: \(generatorViewModel.num2)").onAppear{
                    generatorViewModel.startGeneratingData()
                    generatorViewModel.storeData(itemID: idFromQR)
                }
                .onDisappear {
                   generatorViewModel.stopGeneratingData()
                }
            }
            if(generatorViewModel.workTime != 0){
                Text("Czas pracy: \(generatorViewModel.workTime)").onAppear{
                    generatorViewModel.startGeneratingData()
                    generatorViewModel.storeData(itemID: idFromQR)
                }
                .onDisappear {
                   generatorViewModel.stopGeneratingData()
                }
            }
          
        }.onAppear{
            readItemViewModel.fetchItem(with: idFromQR)
            readActiveViewModel.fetchItem(with: idFromQR)
        }
        HStack{
            Button{
                isEdit = !isEdit
            } label:{
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.green)
                        .padding(10)
                        .frame(width: 150, height: 50)
                    Text("Edytuj \(Image(systemName: "pencil"))")
                        .foregroundStyle(.white)
                        .padding()
                        .bold()
                        .font(.system(size: 16))
                }
            }
            Button{
                readItemViewModel.delete(id: idFromQR)
            } label:{
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.red)
                        .padding(10)
                        .frame(width: 150, height: 50)
                    Text("Usuń \(Image(systemName: "trash"))")
                        .foregroundStyle(.white)
                        .padding()
                        .bold()
                        .font(.system(size: 16))
                }
            }
        }
    }
}

//#Preview {
//    DisplayItem()
//}
