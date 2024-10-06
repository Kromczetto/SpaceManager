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
                
                CustomProperties(isCustomProperty: $templateViewModel.isDBReading)
                    .onAppear {
                        print(addNewItemViewModel.propertyKey)
                    }
                    .onChange(of: templateViewModel.isDBReading) {
                        print("zmienna \(templateViewModel.isDBReading)")
                    }
                    .environmentObject(addNewItemViewModel)
                    .environmentObject(templateViewModel)
                
                BtnDatabase(btnLabel: "Dodaj") {
                    if let last = addNewItemViewModel.propertyKey.last {
                        
                        if !addNewItemViewModel.isFail {
                            templateViewModel.addNewTemplate(selectedItem: selectedOption, propertyKey: addNewItemViewModel.propertyKey)
                            templateViewModel.options[0] = "Nowy szablon"
                        }
                        
                    
                       // print(!last.isEmpty)
                        if addNewItemViewModel.propertyKey.count > addNewItemViewModel.properties.count {
                            addNewItemViewModel.propertyKey.removeLast()
                            addNewItemViewModel.propertyValue.removeLast()
                            addNewItemViewModel.createProperty()
                            print("dluzsze")
                            print("PROPERTY: \(addNewItemViewModel.propertyKey)")
//                            addNewItemViewModel.propertyKey.removeLast()
//                            addNewItemViewModel.propertyValue.removeLast()
//                            addNewItemViewModel.createProperty()

                            addNewItemViewModel.splitArray()
                            print("PROPERTies: \(addNewItemViewModel.properties)")
                            print("Nie mozna byc puste")
//                            addNewItemViewModel.propertyKey.removeLast()
                            qrCodeToSave = qrCodeGenerator.generatorQr(from: productID)
                            UIImageWriteToSavedPhotosAlbum(qrCodeToSave!, nil, nil, nil)
                            addNewItemViewModel.itemID = productID
                            if let tempArr = addNewItemViewModel.properties.last {
                                if tempArr.isEmpty {
                                    addNewItemViewModel.properties.removeLast()
                                    addNewItemViewModel.addItemToDatabase()
                                } else {
                                    addNewItemViewModel.addItemToDatabase()
                                }
                            }
                            
                            productID = UUID().uuidString
                            addNewItemViewModel.properties.removeAll()
                            addNewItemViewModel.propertyKey.removeAll()
                            addNewItemViewModel.propertyValue.removeAll()
                            addNewItemViewModel.listIndex = 0
                        } else {
                            addNewItemViewModel.propertyKey.removeLast()
                            addNewItemViewModel.propertyValue.removeLast()
                            print(addNewItemViewModel.properties)
                            print(addNewItemViewModel.propertyKey)
                            print(addNewItemViewModel.propertyValue)
                        }
                        if !last.isEmpty {
                            
                            qrCodeToSave = qrCodeGenerator.generatorQr(from: productID)
                            UIImageWriteToSavedPhotosAlbum(qrCodeToSave!, nil, nil, nil)
                            addNewItemViewModel.itemID = productID
                            if let tempArr = addNewItemViewModel.properties.last {
                                if tempArr.isEmpty {
                                    addNewItemViewModel.properties.removeLast()
                                    addNewItemViewModel.addItemToDatabase()
                                } else {
                                    addNewItemViewModel.addItemToDatabase()
                                }
                            }
                            productID = UUID().uuidString
                            addNewItemViewModel.properties.removeAll()
                            addNewItemViewModel.propertyKey.removeAll()
                            addNewItemViewModel.propertyValue.removeAll()
                            addNewItemViewModel.listIndex = 0
                         
                        } else {
                            //poprawic bo gdzies jest blad
//                            addNewItemViewModel.isFail = true
//                            addNewItemViewModel.message = "Żadne pole nie moze być puste"
                            
                        }
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
