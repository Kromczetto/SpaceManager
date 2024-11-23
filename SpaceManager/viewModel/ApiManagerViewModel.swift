//
//  ApiManagerViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 05/09/2024.
//

import Foundation
import SwiftUI
class ApiManagerViewModel: ObservableObject {
    @Published var apiUrl: String = "https://machineapi-fr80.onrender.com/machine/673a69193ea4092c2261aa65"
    @Published var jsonData: [String: String]? = nil 
    
    func performAPICall() async throws {
        guard let url = URL(string: apiUrl) else {
            print("Invalid URL")
            return
        }
        let (data, _) = try await URLSession.shared.data(from: url)
  
        if let jsonString = String(data: data, encoding: .utf8) {
            print("API Response: \(jsonString)")
        } else {
            print("No response data")
        }
        do {
            let apiResponse = try JSONDecoder().decode(Api.self, from: data)
            self.jsonData = [
                "id": apiResponse.id,
                "machineName": apiResponse.machineName,
                "parm1": apiResponse.parm1,
                "parm2": apiResponse.parm2,
                "parm3": apiResponse.parm3,
                "parm4": apiResponse.parm4
            ]
        } catch {
            print("Decoding error: \(error)")
            throw error
        }
    }
}

