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
    
    private var productID: String = UUID().uuidString
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(colors: [Color("ligtherGray"),Color("deepGray")],
                               startPoint: .top, endPoint: UnitPoint.bottom)
                                .ignoresSafeArea()
                VStack{
                    Spacer()
                    Group{
                        Image(uiImage: qrCodeGenerator.generatorQr(from: productID))
                            .resizable()
                            .interpolation(.none)
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                       
                              
                        Form{
                            TextField("Nazwa", text: $logManager.itemName)
                            TextField("Ilość", text: $logManager.numberOfItems)
                            TextField("Waga", text: $logManager.weight)
                            TextField("Uwagi", text: $logManager.comments)
                            BtnDatabase(btnLabel: "Dodaj"){

                                logManager.addItemToDatabase()
                            }
                            .alert("Dodano przedmiot", isPresented: $logManager.isSuccess) {
                                           Button("OK", role: .cancel) { }
                            }
                            .alert("Problem z dodaniem przedmiotu",
                                   isPresented: $logManager.isFail) {
                                           Button("OK", role: .cancel) { }
                            }
                        }
                    }
                    BottomMenu()
                }
            }
        }
            
        }
    
}

#Preview {
    LoggedMainView()
}
