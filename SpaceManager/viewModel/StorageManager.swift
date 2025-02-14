//
//  StorageManager.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 22/07/2024.
//

import Foundation
import SwiftUI
import FirebaseStorage
import FirebaseAuth


class StorageManager: ObservableObject {
    @Published var image: UIImage?
    
    let storage = Storage.storage()
    var hasPhoto: Bool = false
    func uploadImage(img: UIImage) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        guard let image = img.jpegData(compressionQuality: 0.5) else {
            print("Compressing error")
            return
        }
        let ref = storage.reference().child("profile/\(uid)")
        ref.putData(image, metadata: nil) { metadata, error in
            if let error = error {
                print("Error with upload into storage")
                return
            }
            print("Stored")
        }
        ref.downloadURL { url, error in
            if let error = error {
                print("Download image error")
                return
            }
            print("Url downloaded")
        }
    }
    func readImageFromStore() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        print(uid)
        let ref = storage.reference(withPath: "profile/\(uid)" )
        ref.getData(maxSize: 2048 * 2048) { data, err in
            if let err = err {
                print("Problem with reading photo: \(err.localizedDescription)")
                self.hasPhoto = false
                return
            } else {
                self.image = UIImage(data: data!)
                print(data!)
                self.hasPhoto = true
            }
        }
    }
    init() {
        readImageFromStore()
    }
}
