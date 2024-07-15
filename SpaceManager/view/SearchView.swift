//
//  SearchView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 12/05/2024.
//

import SwiftUI
import CodeScanner
import FirebaseAuth

struct SearchView: View {
    @State var isCameraOpen: Bool = false
    @State var messageFromQR: String = "id: "
    @State var isRead: Bool = false
    
    @EnvironmentObject var permissionViewModel: PermissionViewModel
    
    var camera: some View {
        CodeScannerView(
            codeTypes: [.qr],
            completion: {
                result in
                if case let .success(code) = result {
                    self.messageFromQR = code.string
                    self.isCameraOpen = false
                    self.isRead = true
                }
            }
        )
    }
    
    var body: some View {
        VStack {
            Spacer()
            if(permissionViewModel.canUserRead){
                Button {
                    self.isCameraOpen = true
                } label :{
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.blue)
                            .padding(10)
                            .frame(width: 350, height: 80)
                        Text("Skanuj kod QR")
                            .foregroundStyle(.white)
                            .padding()
                            .bold()
                            .font(.system(size: 16))
                    }
                }
                .sheet(isPresented: $isCameraOpen) {
                    self.camera
                }
            }else{
                Text("Nie masz uprawnień do odczytywania kodów QR")
                    .foregroundStyle(.red)
            }
            
            NavigationLink(destination: ReadItem(messageFromQR: messageFromQR).navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: CustomBack(title:"Skanuj")),
                           isActive: $isRead) {
                EmptyView()
            }
            Spacer()
        }
    }
}

#Preview {
    SearchView()
}
