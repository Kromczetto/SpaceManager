//
//  CameraView.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 17/07/2024.
//

import SwiftUI
import AVFoundation

struct CameraView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    let cameraService: CameraService
    let didFinishedProcessingPhoto: (Result<AVCapturePhoto, Error>) -> ()
    
    func makeUIViewController(context: Context) -> UIViewController {
        cameraService.start(delegate: context.coordinator) { err in
            if let err = err {
                didFinishedProcessingPhoto(.failure(err))
                return
            }
        }
        let viewController = UIViewController()
        viewController.view.backgroundColor = .black
        viewController.view.layer.addSublayer(cameraService.previewLayer)
        cameraService.previewLayer.frame = viewController.view.bounds
        return viewController
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self, didFinishProcessingPhoto: didFinishedProcessingPhoto)
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

