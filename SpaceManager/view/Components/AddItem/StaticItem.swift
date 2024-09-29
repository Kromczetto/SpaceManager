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
    @Binding var selectedOption: String
    @StateObject var qrCodeGenerator = QrCodeGenerator()
    @EnvironmentObject var permissionViewModel: PermissionViewModel
    @EnvironmentObject var templateViewModel: TemplateViewModel
    @EnvironmentObject var addNewItemViewModel: AddNewItemViewModel
    
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
                
                CustomProperties()
                    .environmentObject(addNewItemViewModel)
                
                BtnDatabase(btnLabel: "Dodaj") {
                    addNewItemViewModel.splitArray()
                    qrCodeToSave = qrCodeGenerator.generatorQr(from: productID)
                    UIImageWriteToSavedPhotosAlbum(qrCodeToSave!, nil, nil, nil)
                    addNewItemViewModel.itemID = productID
                    addNewItemViewModel.addItemToDatabase()
                    productID = UUID().uuidString
                    if !addNewItemViewModel.isFail {
                        templateViewModel.addNewTemplate(selectedItem: selectedOption, propertyKey: addNewItemViewModel.propertyKey)
                        templateViewModel.options[0] = "Nowy szablon"
                    }
                   
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

//#Preview {
//    StaticItem()
//}
