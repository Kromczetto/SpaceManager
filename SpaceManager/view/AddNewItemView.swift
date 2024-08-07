//
//  LoggedMainView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 03/05/2024.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct AddNewItemView: View {
    
    @StateObject var logManager = AddNewItemViewModel()
    @StateObject var qrCodeGenerator = QrCodeGenerator()
    @StateObject var activeHandlerViewModel = ActivevHandlerViewModel()
    //@StateObject var permissionViewModel = PermissionViewModel()
    @EnvironmentObject var permissionViewModel: PermissionViewModel
    @EnvironmentObject var generatorViewModel: GeneratorViewModel
    
    @State var productID: String = UUID().uuidString
    
    @State private var isFirstCheck: Bool = false
    @State private var isSecondCheck: Bool = false
    @State private var isThirdCheck: Bool = false
    @State private var canAdd: Bool = false

    
    @State private var qrCodeToSave: UIImage? = nil
    
    var body: some View {
       
        ZStack{
            LinearGradient(colors: [Color("ligtherGray"),Color("deepGray")],
                           startPoint: .top, endPoint: UnitPoint.bottom)
                            .ignoresSafeArea()
            VStack{
                Spacer()
                HStack(spacing: 0){
                   
                    BtnItemType(){
                        generatorViewModel.isStatic = true
                        generatorViewModel.setSpins(number: 0)
                        generatorViewModel.setConsumption(number: 0)
                        generatorViewModel.setWorkTime(number: 0)
                        
                    }
                    BtnItemType(btnText: "Aktywne",
                                firstColor: .gray,
                                secondColor: .blue,
                                state: false
                    ){
                        generatorViewModel.isStatic = false
                        generatorViewModel.setSpins(number: 10)
                        generatorViewModel.setConsumption(number: 10)
                        generatorViewModel.setWorkTime(number: 100)
                        
                    }
                }.padding(10).onAppear{
                    generatorViewModel.isStatic = true
                    generatorViewModel.setSpins(number: 0)
                    generatorViewModel.setConsumption(number: 0)
                    generatorViewModel.setWorkTime(number: 0)
                    
                   // permissionViewModel.getPermission()
                }
                Spacer()
                permissionViewModel.canUserAdd ? nil : Text("Nie posiadasz uprawnień, aby dodać przedmiot")
                Group{
                    Form{
                        GeometryReader { geometry in
                            Image(uiImage: qrCodeGenerator.generatorQr(from: productID)!)
                                .resizable()
                                .interpolation(.none)
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        }.frame(minHeight: 200)
                        
                        TextField("Nazwa", text: $logManager.itemName)
                        TextField("Ilość", text: $logManager.numberOfItems)
                        TextField("Waga", text: $logManager.weight)
                        TextField("Uwagi", text: $logManager.comments)
                        if(!generatorViewModel.isStatic){
                                Checkbox(isChecked: $isFirstCheck,
                                         checkName: "Obroty silnika")
                                Checkbox(isChecked: $isSecondCheck,
                                         checkName: "Zużycie prądu")
                                Checkbox(isChecked: $isThirdCheck,
                                         checkName: "Czas pracy")
                        }
                     
                        BtnDatabase(btnLabel: "Dodaj"){
                            qrCodeToSave = qrCodeGenerator.generatorQr(from: productID)
                            UIImageWriteToSavedPhotosAlbum(qrCodeToSave!, nil, nil, nil)
                            logManager.itemID = productID
                            logManager.addItemToDatabase()
                            if (!generatorViewModel.isStatic ){
                                if(!isFirstCheck){ generatorViewModel.setSpins(number: 0)
                                }
                                if(!isSecondCheck){generatorViewModel.setConsumption(number: 0)
                                }
                                if(!isThirdCheck){ generatorViewModel.setWorkTime(number: 0)
                                }
                                generatorViewModel.storeData(itemID: productID)
                                isFirstCheck = false
                                isSecondCheck = false
                                isThirdCheck = false
                            } else{
                                generatorViewModel.storeData(itemID: productID)
                                isFirstCheck = false
                                isSecondCheck = false
                                isThirdCheck = false
                            }
                            productID = UUID().uuidString
                            
                        }
                        
                        .alert("Dodano \($logManager.itemNameHolder.wrappedValue), kod QR został zapisany w galerii zdjęć",
                               isPresented: $logManager.isSuccess) {
                                       Button("OK", role: .cancel) { }
                        }
                        .alert("\($logManager.message.wrappedValue)",
                               isPresented: $logManager.isFail) {
                                       Button("OK", role: .cancel) { }
                        }
                    }
                }.disabled(!permissionViewModel.canUserAdd)
                    .opacity(permissionViewModel.canUserAdd ? 1 : 0.4)
            }
        }
    }
    
}

#Preview {
    AddNewItemView()
}
