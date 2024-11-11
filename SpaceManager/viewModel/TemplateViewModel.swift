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
    @Published var tids: [String] = [""]
    @Published var properties: [String] = [""]
    @Published var nameTid: [String: String] = [:]
    @Published var template: Template?
    @Published var isDBReading: Bool = false
    func checkIsNameTaken(name: String) -> Bool{
        for (index, option) in options.enumerated() {
            if name == option {
                return true
            }
        }
        return false
    }
    func checkIsNameSet(name: String) -> Bool {
        if name == "Nowy szablon" {
            return false
        }
        return true
    }
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
    func getTemplateFromDB() {
        options.removeAll()
        options.append("Nowy szablon")
        tids.removeAll()
        tids.append("")
        properties.removeAll()
        properties.append("")
        nameTid.removeAll()
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
                    if let templateTid = dictionary["tid"] as? String {
                        self.tids.append(templateTid)
                    }
                })
                var index: Int = 0
                for option in self.options {
                    self.nameTid[option] = self.tids[index]
                    index = index + 1
                }
            }
    }
    func getProperties(tid: String, completion: @escaping () -> Void) {
        print(tid)
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let docRef = db.collection("users")
            .document(uid)
            .collection("templates")
            .document(tid)
            .getDocument { (document, err) in
                if let document = document, document.exists {
                    do {
                        self.template = try document.data(as: Template.self)
                        completion()
                    } catch {
                        print("Problem z odczytaniem przedmiotu")
                    }
                } else {
                    print("kolekcja nie istnije \(err?.localizedDescription)")
                }
        }
}
}
