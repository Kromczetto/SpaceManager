//
//  CameraViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 28/06/2024.
//

import Foundation

class CameraViewModel: ObservableObject{
    @Published var isCameraOpen: Bool = false
    @Published var messageFromQR: String = "id: "
}
