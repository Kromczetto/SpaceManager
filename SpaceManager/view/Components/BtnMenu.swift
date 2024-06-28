//
//  BtnMenu.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 04/05/2024.
//

import SwiftUI

struct BtnMenu: View {
    
    
    var btnText: String
    var btnIcon: String
    //var btnEvent: ()->Void
    var destinationView: AnyView
    
    var body: some View {
        NavigationLink{
                destinationView
        }label:{
            ZStack{
                Text("\(Image(systemName: btnIcon)) \(btnText)")
                    
            }
            
        }
    }
}


