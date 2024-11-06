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
    @State private var secondIteration: Bool = false
    @Binding var selectedOption: String
    @EnvironmentObject var qrCodeGenerator: QrCodeGenerator
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
                
                CustomProperties(isCustomProperty: $templateViewModel.isDBReading, 
                                 secondIteration: $secondIteration)
//                    .onAppear {
//                        print(addNewItemViewModel.propertyKey)
//                    }
//                    .onChange(of: templateViewModel.isDBReading) {
//                        print("zmienna \(templateViewModel.isDBReading)")
//                    }
                    .environmentObject(addNewItemViewModel)
                    .environmentObject(templateViewModel)
                
                BtnDatabase(btnLabel: "Dodaj") {
                    addNewItemViewModel.isArrayEmpty()
                    if let lastKey = addNewItemViewModel.propertyKey.last {
                        if !addNewItemViewModel.isFail {
                            templateViewModel.addNewTemplate(selectedItem: selectedOption, propertyKey: addNewItemViewModel.propertyKey)
                            templateViewModel.options[0] = "Nowy szablon"
                        }
                        if lastKey.isEmpty {
                            addNewItemViewModel.propertyKey.removeLast()
                            addNewItemViewModel.propertyValue.removeLast()
                        }
                        addNewItemViewModel.createProperty()
                        qrCodeToSave = qrCodeGenerator.generatorQr(from: productID)
                        UIImageWriteToSavedPhotosAlbum(qrCodeToSave!, nil, nil, nil)
                        addNewItemViewModel.itemID = productID
                        addNewItemViewModel.addItemToDatabase()
                        productID = UUID().uuidString
                        addNewItemViewModel.properties.removeAll()
                        addNewItemViewModel.propertyKey.removeAll()
                        addNewItemViewModel.propertyValue.removeAll()
                        secondIteration = false
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
