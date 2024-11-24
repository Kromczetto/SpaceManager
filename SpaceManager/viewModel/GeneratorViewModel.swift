//
//  GeneratorViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 01/07/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class GeneratorViewModel: ObservableObject {
    @Published var isStatic: Bool = true
   
    @Published var num1: Int
    @Published var num2: Int
    @Published var workTime: Int
    
    private var counter: Int = 0
    
    var timer: Timer?

    init() {
        num1 = Int.random(in: 100 ..< 1000)
        num2 = Int.random(in: 100 ..< 1000)
        workTime = 100
        startGeneratingData()
    }

    func startGeneratingData() {
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
            self.generateData()
        }
    }

    func stopGeneratingData() {
        timer?.invalidate()
        timer = nil
    }

    private func generateData() {
        counter = counter + 1
        if num1 != 0 {
            num1 = Int.random(in: 100 ..< 1000)
        }
        if num2 != 0 {
            num2 = Int.random(in: 100 ..< 1000)
        }
        if counter == 100 {
            workTime = workTime + 1
            counter = 0
        }
    }
    
    func storeData(itemID: String) {
        guard let userID = Auth.auth().currentUser?.uid else{
            return
        }
        let newItem = (id: itemID,
                       numberOfSpins: num1,
                       electricityConsumpsion: num2,
                       workingTime: workTime
        )
        let db = Firestore.firestore()
        db.collection("users")
            .document(userID)
            .collection("activeItems")
            .document(itemID)
            .setData(["id": newItem.id,
                      "numberOfSpins": newItem.numberOfSpins,
                      "electricityConsumpsion": newItem.electricityConsumpsion,
                      "workingTime": newItem.workingTime
                   
            ])
    }
    func setSpins(number: Int) {
        num1 = number
    }
    func setConsumption(number: Int) {
        num2 = number
    }
    func setWorkTime(number: Int) {
        workTime = number
    }
}
