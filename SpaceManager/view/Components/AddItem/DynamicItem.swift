//
//  DynamicItem.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 29/08/2024.
//

import SwiftUI

struct DynamicItem: View {
    @State var productID: String
    @State private var qrCodeToSave: UIImage? = nil
    @StateObject var apiManagerViewModel = ApiManagerViewModel()
    @EnvironmentObject var dynamicItemViewModel: DynamicItemViewModel
    @EnvironmentObject var addNewItemViewModel: AddNewItemViewModel
    @EnvironmentObject var permissionViewModel: PermissionViewModel
    @EnvironmentObject var qrCodeGenerator: QrCodeGenerator
    var body: some View {
        permissionViewModel.canUserAdd ? nil : Text("Nie posiadasz uprawnień, aby dodać przedmiot")
        Group {
            Form {
                QRCode(productID: productID)
                    .environmentObject(qrCodeGenerator)

                BasicForm(itemName: $addNewItemViewModel.itemName,
                          numberOfItems: $addNewItemViewModel.numberOfItems,
                          weight: $addNewItemViewModel.weight,
                          comments: $addNewItemViewModel.comments)
//                ODKOMENTOWAC GDY BEDZIEMY ROBILI CZYTANIE DLA AKTYTWNYCH
//                CustomProperties()
//                    .environmentObject(addNewItemViewModel)
                
                DynamicApi()
                    .environmentObject(dynamicItemViewModel)
                    .environmentObject(apiManagerViewModel)
                
                BtnDatabase(btnLabel: "Dodaj") {
                    //addNewItemViewModel.splitArray()
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
    DynamicItem(productID: "ID")
}
