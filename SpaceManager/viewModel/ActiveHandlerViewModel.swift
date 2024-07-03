//
//  ActiveHandlerViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 03/07/2024.
//

import Foundation

class ActivevHandlerViewModel: ObservableObject{
    @Published var firstCheck: Bool = false
    @Published var secondCheck: Bool = false
    @Published var thirdCheck: Bool = false
    
    func setFirst(state: Bool){
        firstCheck = state
    }
    func setSecond(state: Bool){
        secondCheck = state
    }
    func setThird(state: Bool){
        thirdCheck = state
    }
}
