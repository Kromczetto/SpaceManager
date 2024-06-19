//
//  LoggedMainView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 03/05/2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
import CoreImage
import CoreImage.CIFilterBuiltins

struct LoggedMainView: View {
    
    @StateObject var logManager = MainViewModel()
    @State private var itemName: String = ""
    @State private var numberOfItems: String = ""
    @State private var resposablePerson: String = ""
    @State private var comments: String = ""
    
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(colors: [Color("ligtherGray"),Color("deepGray")],
                               startPoint: .top, endPoint: UnitPoint.bottom)
                                .ignoresSafeArea()
              
                VStack{
                    Spacer()
                    Group{
                        Image(uiImage: generateQRCode(from: "\($itemName)"))
                            .resizable()
                            .interpolation(.none)
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                        
                              
                        Form{
                            TextField("Nazwa", text: $itemName)
                            TextField("Ilość", text: $numberOfItems)
                            TextField("Osoba dodająca", text: $resposablePerson)
                            TextField("Uwagi", text: $comments)
                        }
                    }
                    BottomMenu()
                }
            }
        }
            
        }
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    LoggedMainView()
}
//Button{
//    do{
//        try Auth.auth().signOut()
//        logManager.logged = false
//    }catch{
//        print("Błąd podczas wylogowywania")
//    }} label: {
//    ZStack{
//        RoundedRectangle(cornerRadius: 20)
//
//            .padding(10)
//        Text("Wyloguj")
//
//            .padding()
//            .bold()
//
//    }
