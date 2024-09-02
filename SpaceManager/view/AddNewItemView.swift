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
    
    @StateObject var addNewItemViewModel = AddNewItemViewModel()
    @StateObject var qrCodeGenerator = QrCodeGenerator()
    @StateObject var dynamicItemViewModel = DynamicItemViewModel()
    @StateObject var activeHandlerViewModel = ActivevHandlerViewModel()
    @EnvironmentObject var permissionViewModel: PermissionViewModel
    @EnvironmentObject var generatorViewModel: GeneratorViewModel
    
    @State var productID: String = UUID().uuidString
    
    @State private var isFirstCheck: Bool = false
    @State private var isSecondCheck: Bool = false
    @State private var isThirdCheck: Bool = false
    @State private var canAdd: Bool = false
    
//    @State private var qrCodeToSave: UIImage? = nil
    @State private var isCustionProperty: Bool = false
    
    var body: some View {
       
        ZStack{
            LinearGradient(colors: [Color("ligtherGray"),Color("deepGray")],
                           startPoint: .top, endPoint: UnitPoint.bottom)
                            .ignoresSafeArea()
            VStack {
                Spacer()
                HStack(spacing: 0) {
                    BtnItemType() {
                        generatorViewModel.isStatic = true
                    }
                    BtnItemType(btnText: "Aktywne",
                                firstColor: .gray,
                                secondColor: .blue,
                                state: false
                    ) {
                        generatorViewModel.isStatic = false
                    }
                }.padding(10)
                .onAppear {
                    generatorViewModel.isStatic = true
                }
                Spacer()
                if generatorViewModel.isStatic {
                    StaticItem(productID: productID)
                        .environmentObject(permissionViewModel)
                        //.environmentObject(generatorViewModel)
                        .environmentObject(addNewItemViewModel)
                } else {
                    //przekazad productID zeby potem przekazac w dynamic do static
                    DynamicItem(productID: productID)
                        .environmentObject(permissionViewModel)
                        .environmentObject(generatorViewModel)
                        .environmentObject(addNewItemViewModel)
                        .environmentObject(dynamicItemViewModel)
                }
            }
        }
    }
}

#Preview {
    AddNewItemView()
}
