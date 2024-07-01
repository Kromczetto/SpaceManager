//
//  SearchContentView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 28/06/2024.
//

import SwiftUI

struct SearchContentView: View {
    
    @Binding var messageFromQR: String
    @Binding var isCameraOpen: Bool
      
      var body: some View {
          VStack {
              Text(messageFromQR)
              Button("Skanuj kod QR") {
                  self.isCameraOpen = true
              }
          }
          .padding()
      }
}

