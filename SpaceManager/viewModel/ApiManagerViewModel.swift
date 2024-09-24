//
//  ApiManagerViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 05/09/2024.
//

import Foundation

class ApiManagerViewModel: ObservableObject {
    @Published var apiUrl: String = "https://jsonplaceholder.typicode.com/users"
    @Published var value: Any = ""
    @Published var jsonData: [String: Any]? = nil

    func setUrl(url: String) {
        apiUrl = url
    }
    func getData(key: String) {
        guard let url = URL(string: apiUrl) else {
            print("Error with reading API")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, res, err in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            guard let data = data else {
                print("No data")
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Decding")
                    self.jsonData = json
                    self.getValue(key: key, from: self.jsonData)
                }
            } catch {
                print("Decoding JSON error")
            }
        }
        task.resume()
    }
    func getValue(key: String, from json: [String: Any]?) {
        print("getting value")
        guard let jsonWrapped = json else {
            return
        }
        if let jsonValue = jsonWrapped[key] {
            self.value = jsonValue
            print("value: \(self.value)")
        }
    }
}
