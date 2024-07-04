//
//  LoggedMainView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 03/05/2024.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoggedMainView: View {
    
    @StateObject var logManager = MainViewModel()
    @StateObject var qrCodeGenerator = QrCodeGenerator()
    @StateObject var generatorViewModel = GeneratorViewModel()
    @StateObject var activeHandlerViewModel = ActivevHandlerViewModel()
    
    @State var productID: String = UUID().uuidString
    
    @State var isFirstCheck: Bool = false
    @State private var isSecondCheck: Bool = false
    @State private var isThirdCheck: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(colors: [Color("ligtherGray"),Color("deepGray")],
                               startPoint: .top, endPoint: UnitPoint.bottom)
                                .ignoresSafeArea()
                VStack{
                    Spacer()
                    HStack(spacing: 0){
                       
                        BtnItemType()
                        BtnItemType(btnText: "Aktywne",
                                    firstColor: .gray,
                                    secondColor: .blue,
                                    state: false
                        )
                    }.padding(10)
                    Spacer()
                    Group{
                              
                        Form{
                            GeometryReader { geometry in
                                Image(uiImage: qrCodeGenerator.generatorQr(from: productID))
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
                                             checkName: "Obroty silnika",
                                             activeHandler: activeHandlerViewModel)
                                    Checkbox(isChecked: $isSecondCheck, 
                                             checkName: "Zużycie prądu",
                                             activeHandler: activeHandlerViewModel)
                                    Checkbox(isChecked: $isThirdCheck, 
                                             checkName: "Czas pracy",
                                             activeHandler: activeHandlerViewModel)
                            }
                            BtnDatabase(btnLabel: "Dodaj"){
                                logManager.itemID = productID
                                logManager.addItemToDatabase()
                                if (!generatorViewModel.isStatic ){
                                    if(!isFirstCheck){ generatorViewModel.setSpins(number: 0)}
                                    if(!isSecondCheck){generatorViewModel.setConsumption(number: 0)}
                                    if(!isThirdCheck){ generatorViewModel.setWorkTime(number: 0)}
                                    generatorViewModel.storeData(itemID: productID)
                                    isFirstCheck = false
                                    isSecondCheck = false
                                    isThirdCheck = false
                                }
                                productID = UUID().uuidString
                            }
                            
                            .alert("Dodano \($logManager.itemNameHolder.wrappedValue)",
                                   isPresented: $logManager.isSuccess) {
                                           Button("OK", role: .cancel) { }
                            }
                            .alert("\($logManager.message.wrappedValue)",
                                   isPresented: $logManager.isFail) {
                                           Button("OK", role: .cancel) { }
                            }
                        }
                    }
                    BottomMenu()
                }
            }
        }
        .environmentObject(generatorViewModel)
    }
    
}

#Preview {
    LoggedMainView()
}
