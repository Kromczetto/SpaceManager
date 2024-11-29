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
    @StateObject var templateViewModel = TemplateViewModel()
    @StateObject var generatorViewModel = GeneratorViewModel()
    @EnvironmentObject var permissionViewModel: PermissionViewModel
    @EnvironmentObject var statsViewModel: StatsViewModel
    
    @State var productID: String = UUID().uuidString
    @State private var isFirstCheck: Bool = false
    @State private var isSecondCheck: Bool = false
    @State private var isThirdCheck: Bool = false
    @State private var canAdd: Bool = false
    @State private var selectedOption = "Nowy szablon"
    @State private var isCustionProperty: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("ligtherGray"),Color("deepGray")],
                           startPoint: .top, endPoint: UnitPoint.bottom)
                            .ignoresSafeArea()
            VStack {
                Spacer()
                HStack(spacing: 0) {
                    BtnItemType() {
                        generatorViewModel.isStatic = true
                    }.environmentObject(generatorViewModel)
                    BtnItemType(btnText: "Aktywne",
                                firstColor: .gray,
                                secondColor: .blue,
                                state: false
                    ) {
                        generatorViewModel.isStatic = false
                    }.environmentObject(generatorViewModel)
                }.padding(10)
                .onAppear {
                    generatorViewModel.isStatic = true
                }
                Spacer()
                TemplateList(selectedOption: $templateViewModel.selectedItem)
                    .environmentObject(templateViewModel)
                    .environmentObject(addNewItemViewModel)
                Spacer()
                if generatorViewModel.isStatic {
                    StaticItem(productID: productID, selectedOption: $templateViewModel.selectedItem)
                        .environmentObject(qrCodeGenerator)
                        .environmentObject(permissionViewModel)
                        .environmentObject(templateViewModel)
                        .environmentObject(addNewItemViewModel)
                        .environmentObject(statsViewModel)
                } else {
                    DynamicItem(productID: productID, selectedOption: $templateViewModel.selectedItem)
                        .environmentObject(permissionViewModel)
                        .environmentObject(qrCodeGenerator)
                        .environmentObject(addNewItemViewModel)
                        .environmentObject(dynamicItemViewModel)
                        .environmentObject(templateViewModel)
                        .environmentObject(statsViewModel)
                }
            }
        }
    }
}

#Preview {
    AddNewItemView()
}
