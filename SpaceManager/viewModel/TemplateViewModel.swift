//
//  TemplateViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 13/09/2024.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class TemplateViewModel: ObservableObject {
    @Published var selectedItem: String = "Nowy szablon"
    @Published var options: [String] = ["Nowy szablon"] //, "Opcja1", "Opcja2", "Opcja3"
    @Published var properties: [String] = [""]
    func addNewTemplate(selectedItem: String, propertyKey: [String]) {
        options.append(selectedItem)
        let tid: String = UUID().uuidString
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let template = Template(tid: tid,
                                name: selectedItem,
                                propertiesKey: propertyKey
        )
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("templates")
            .document(tid)
            .setData(template.toDictionary()) { err in
                print(err?.localizedDescription)
            }
        print("Adding template... \(selectedItem) and we have a prop: \(propertyKey[0])")
    }
    func isNewTemplate() -> Bool {
        return false
    }
    func getTemplateFromDB() {
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        db.collection("users")
            .document(uid)
            .collection("templates")
            .getDocuments { (snap, err) in
                snap?.documents.forEach({ doc in
                    let dictionary = doc.data()
                    if let templateName = dictionary["name"] as? String {
                        self.options.append(templateName)
                    }
                    if let templateProperties = dictionary["propertiesKey"] as? [String] {
                        for property in templateProperties {
                            self.properties.append(property)
                        }
                    }
                })
            }
    }
}
