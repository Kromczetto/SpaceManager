//
//  ProfileView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 16/05/2024.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Spacer()
        
        BtnProfile()
        Spacer()
    }
}

#Preview {
    ProfileView()
}
