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
    @EnvironmentObject var statsViewModel: StatsViewModel
    
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
                    .environmentObject(addNewItemViewModel)
                    .environmentObject(templateViewModel)
                
                BtnDatabase(btnLabel: "Dodaj") {
                    addNewItemViewModel.isArrayEmpty()
                    DispatchQueue.main.async {
                        if let lastKey = addNewItemViewModel.propertyKey.last {
                            if !templateViewModel.checkIsNameTaken(name: selectedOption) ||
                                selectedOption == "Nowy szablon" {
                                addNewItemViewModel.isFail = true
                                addNewItemViewModel.message = "Ustaw nazwe szablonu"
                                return
                            }
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
                            templateViewModel.isDBReading = false
                            secondIteration = false
                            statsViewModel.readStats()
                            selectedOption = "Nowy szablon"
                        } else {
                            if addNewItemViewModel.propertyKey.isEmpty {
                                qrCodeToSave = qrCodeGenerator.generatorQr(from: productID)
                                UIImageWriteToSavedPhotosAlbum(qrCodeToSave!, nil, nil, nil)
                                addNewItemViewModel.itemID = productID
                                addNewItemViewModel.addItemToDatabase()
                                productID = UUID().uuidString
                                statsViewModel.readStats()
                            }
                        }
                    }
                }
                
                .alert("Dodano \($addNewItemViewModel.itemNameHolder.wrappedValue), kod QR został zapisany w galerii zdjęć",
                       isPresented: $addNewItemViewModel.isSuccess) {
                               Button("OK", role: .cancel) { 
                                   statsViewModel.setNumberOfAddedItems()
                               }
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
