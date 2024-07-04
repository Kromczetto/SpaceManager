//
//  MenuViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 04/07/2024.
//

import Foundation

class MenuViewModel: ObservableObject{
    @Published var currentViewIndex: Int = 0
    
    func setViewIndex(newViewIndex: Int){
       currentViewIndex = newViewIndex
    }
}
