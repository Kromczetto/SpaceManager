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
    @StateObject var activeHandlerViewModel = ActivevHandlerViewModel()
    @EnvironmentObject var permissionViewModel: PermissionViewModel
    @EnvironmentObject var generatorViewModel: GeneratorViewModel
    
    @State var productID: String = UUID().uuidString
    
    @State private var isFirstCheck: Bool = false
    @State private var isSecondCheck: Bool = false
    @State private var isThirdCheck: Bool = false
    @State private var canAdd: Bool = false
    
    @State private var qrCodeToSave: UIImage? = nil
//    private var itemIndex: Int = 0
//    @State private var listIndex: Int = 0
    @State private var isCustionProperty: Bool = false
    
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
                Group {
                    Form {
                        GeometryReader { geometry in
                            Image(uiImage: qrCodeGenerator.generatorQr(from: productID)!)
                                .resizable()
                                .interpolation(.none)
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        }.frame(minHeight: 200)
                        
                        TextField("Nazwa", text: $addNewItemViewModel.itemName)
                        TextField("Ilość", text: $addNewItemViewModel.numberOfItems)
                        TextField("Waga", text: $addNewItemViewModel.weight)
                        TextField("Uwagi", text: $addNewItemViewModel.comments)
                        
                        if isCustionProperty {
                            List {
                                ForEach(Array($addNewItemViewModel.propertyKey.enumerated()), id: \.offset) { index, _ in
                                
                                    HStack{
                                        TextField("Właściość", text: $addNewItemViewModel.propertyKey[index] )
                                        TextField("Wartość", text: $addNewItemViewModel.propertyValue[index] )
                                    }.onAppear {
                                        addNewItemViewModel.createProperty(index: index)
                                        print(addNewItemViewModel.properties)
                                    }
                                }.onDelete(perform: addNewItemViewModel.removeItems)
                            }
                        }
                        Button {
                            isCustionProperty = true
                            print(addNewItemViewModel.listIndex)
                            if addNewItemViewModel.listIndex != 0 {
                                addNewItemViewModel.propertyKey.append("")
                                addNewItemViewModel.propertyValue.append("")
                            }
                            addNewItemViewModel.createProperty(index: addNewItemViewModel.listIndex)
                            addNewItemViewModel.listIndex = addNewItemViewModel.listIndex + 1
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.blue)
                                    .padding(10)
                                    .frame(width: 350, height: 80)
                                Text("+")
                                    .foregroundStyle(.white)
                                    .padding()
                                    .bold()
                                    .font(.system(size: 16))
                            }
                        }.disabled(addNewItemViewModel.canAddNewProperty())
                        
                        if (!generatorViewModel.isStatic) {
                                Checkbox(isChecked: $isFirstCheck,
                                         checkName: "Obroty silnika")
                                Checkbox(isChecked: $isSecondCheck,
                                         checkName: "Zużycie prądu")
                                Checkbox(isChecked: $isThirdCheck,
                                         checkName: "Czas pracy")
                        }
                     
                        BtnDatabase(btnLabel: "Dodaj") {
                            print(addNewItemViewModel.properties)
                            qrCodeToSave = qrCodeGenerator.generatorQr(from: productID)
                            UIImageWriteToSavedPhotosAlbum(qrCodeToSave!, nil, nil, nil)
                            addNewItemViewModel.itemID = productID
                            addNewItemViewModel.addItemToDatabase()
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
    }
}

#Preview {
    AddNewItemView()
}
