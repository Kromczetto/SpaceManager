//
//  DynamicItemViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 29/08/2024.
//

import Foundation

class DynamicItemViewModel: ObservableObject {
    @Published var api: [[String: String]] = []
    @Published var apiConnection: [String] = [""]
    @Published var apiValue: [String] = [""]
    @Published var valueName: [String] = [""]
    @Published var listIndex: Int = 0
 
    private var tempDictionary: [String: String] = [:]
    
    func createApiConnection() {
            print(listIndex)
            tempDictionary[apiConnection[self.listIndex]] = valueName[self.listIndex]
            api.append(tempDictionary)
            tempDictionary.removeAll()
            apiConnection.append("")
            valueName.append("")
            self.listIndex = listIndex + 1
            print(api)
    }
    func removeItems(at offsets: IndexSet) {
        apiConnection.remove(atOffsets: offsets)
        valueName.remove(atOffsets: offsets)
        api.remove(atOffsets: offsets)
        self.listIndex = listIndex - 1
    }
    func canAddNewApi() -> Bool {
        if self.listIndex == 0 {
            return false
        }
        if apiConnection[self.listIndex - 1].isEmpty || valueName[self.listIndex - 1].isEmpty {
            return true
        }
        return false
    }
}
