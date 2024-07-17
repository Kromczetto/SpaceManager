//
//  Coordinator.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 17/07/2024.
//

import Foundation
import AVFoundation

class Coordinator: NSObject, AVCapturePhotoCaptureDelegate {
    let parent: CameraView
    var didFinishProcessingPhoto: (Result<AVCapturePhoto, Error>) -> ()
    
    init(_ parent: CameraView, didFinishProcessingPhoto: @escaping (Result<AVCapturePhoto, Error>) -> ()) {
        self.parent = parent
        self.didFinishProcessingPhoto = didFinishProcessingPhoto
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
           if let error = error {
               didFinishProcessingPhoto(.failure(error))
           } else {
               didFinishProcessingPhoto(.success(photo))
           }
       }
}
