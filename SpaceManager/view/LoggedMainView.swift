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
    @State private var itemName: String = ""
    @State private var numberOfItems: String = ""
    @State private var resposablePerson: String = ""
    @State private var comments: String = ""
    
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
                            TextField("Nazwa", text: $itemName)
                            TextField("Ilość", text: $numberOfItems)
                            TextField("Osoba dodająca", text: $resposablePerson)
                            TextField("Uwagi", text: $comments)
                            BtnDatabase(btnLabel: "Dodaj")
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
