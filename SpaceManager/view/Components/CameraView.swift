//
//  CameraView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 16/07/2024.
//

import SwiftUI

struct CameraView: View{
    
    @StateObject var cameraViewModel = CameraViewModel()
    var body: some View{
        Color.black.ignoresSafeArea(.all, edges: .all)
        VStack{
            Spacer()
            HStack{
                if (cameraViewModel.isTaken){
                    
                }else{
                    Button{
                        cameraViewModel.isTaken.toggle()
                    }label: {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 65, height: 65)
                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                            .frame(width: 75, height: 75)
                    }
                }
            }.onAppear{
                cameraViewModel.checkPermission()
            }
        }
    }
}

#Preview {
    CameraView()
}
