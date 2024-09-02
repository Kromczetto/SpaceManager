//
//  StaticItem.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 29/08/2024.
//

import SwiftUI

struct StaticItem: View {
    @State var productID: String = ""
    @State private var qrCodeToSave: UIImage? = nil
    @StateObject var qrCodeGenerator = QrCodeGenerator()
    @EnvironmentObject var permissionViewModel: PermissionViewModel
   // @EnvironmentObject var generatorViewModel: GeneratorViewModel
    @EnvironmentObject var addNewItemViewModel: AddNewItemViewModel
    
    var body: some View {
        permissionViewModel.canUserAdd ? nil : Text("Nie posiadasz uprawnień, aby dodać przedmiot")
        Group {
            Form {
                GeometryReader { geometry in
                    Image(uiImage: qrCodeGenerator.generatorQr(from: productID)!)
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }.frame(minHeight: 200)
                
                TextField("Nazwa", text: $addNewItemViewModel.itemName)
                TextField("Ilość", text: $addNewItemViewModel.numberOfItems)
                TextField("Waga", text: $addNewItemViewModel.weight)
                TextField("Uwagi", text: $addNewItemViewModel.comments)
                
                CustomProperties()
                    .environmentObject(addNewItemViewModel)
                
                BtnDatabase(btnLabel: "Dodaj") {
                    addNewItemViewModel.splitArray()
                    qrCodeToSave = qrCodeGenerator.generatorQr(from: productID)
                    UIImageWriteToSavedPhotosAlbum(qrCodeToSave!, nil, nil, nil)
                    addNewItemViewModel.itemID = productID
                    addNewItemViewModel.addItemToDatabase()
                    productID = UUID().uuidString
                }
                
                .alert("Dodano \($addNewItemViewModel.itemNameHolder.wrappedValue), kod QR został zapisany w galerii zdjęć",
                       isPresented: $addNewItemViewModel.isSuccess) {
                               Button("OK", role: .cancel) { }
                }
                .alert("\($addNewItemViewModel.message.wrappedValue)",
                       isPresented: $addNewItemViewModel.isFail) {
                               Button("OK", role: .cancel) { }
                }
            }
        }.disabled(!permissionViewModel.canUserAdd)
            .opacity(permissionViewModel.canUserAdd ? 1 : 0.4)
    }
}

#Preview {
    StaticItem()
}
