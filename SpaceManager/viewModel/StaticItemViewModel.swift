//
//  StaticItemViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 29/08/2024.
//

import Foundation

class StaticItemViewModel: ObservableObject {
    private var tempProperty: [String: String] = [:]
    
    @Published var properties: [[String: String]] = []
    @Published var propertyKey: [String] = [""]
    @Published var propertyValue: [String] = [""]
    @Published var listIndex: Int = 0
    func createProperty() {
        if (listIndex == 0) {
            tempProperty[propertyKey[self.listIndex]] = propertyValue[self.listIndex]
            properties.append(tempProperty)
            tempProperty.removeAll()
            propertyKey.append("")
            propertyValue.append("")
            self.listIndex = listIndex + 1
        } else {
            print(listIndex)
            tempProperty[propertyKey[self.listIndex - 1]] = propertyValue[self.listIndex - 1]
            properties.append(tempProperty)
            tempProperty.removeAll()
            propertyKey.append("")
            propertyValue.append("")
            self.listIndex = listIndex + 1
        }
    }
    func removeItems(at offsets: IndexSet) {
        propertyKey.remove(atOffsets: offsets)
        propertyValue.remove(atOffsets: offsets)
        properties.remove(atOffsets: offsets)
        self.listIndex = listIndex - 1
    }
    func canAddNewProperty() -> Bool {
        if (self.listIndex == 0) {
            return false
        }
        if (propertyKey[self.listIndex - 1].isEmpty || propertyValue[self.listIndex - 1].isEmpty) {
            return true
        }
        return false
    }
    func splitArray() {
        if (properties.count > 0 || !properties.isEmpty) {
            properties.removeFirst()
        }
    }
}
