//
//  CameraService.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 17/07/2024.
//

import Foundation
import AVFoundation

class CameraService {
    var session: AVCaptureSession?
    var delegate: AVCapturePhotoCaptureDelegate?
    var cameraSite: AVCaptureDevice?
    let output = AVCapturePhotoOutput()
    let previewLayer = AVCaptureVideoPreviewLayer()
    init(siteOfCamera: AVCaptureDevice.Position){
        cameraSite = getCamera(site: siteOfCamera)
    }
    func start(delegate: AVCapturePhotoCaptureDelegate, completion: @escaping (Error?) -> ()) {
        self.delegate = delegate
        checkPrermissions(completion: completion)
    }
    private func checkPrermissions(completion: @escaping (Error?) -> ()) {
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) {[weak self] granted in
                guard granted else {
                    return
                }
                DispatchQueue.main.async {
                    self?.setUp(completion: completion)
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setUp(completion: completion)
        @unknown default:
            break
        }
    }
    private func setUp(completion: @escaping (Error?) -> ()) {
        let session = AVCaptureSession()
        if let device = cameraSite {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if (session.canAddInput(input)) {
                    session.addInput(input)
                }
                if (session.canAddOutput(output)) {
                    session.addOutput(output)
                }
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                DispatchQueue.global(qos: .background).async {
                               session.startRunning()
                               DispatchQueue.main.async {
                                   self.session = session
                                   completion(nil)
                               }
                           }
            } catch {
                completion(error)
            }
        }
    }
    private func getCamera(site: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let devices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: site).devices
         return devices.first
     }
    func capturePhoto(with settings: AVCapturePhotoSettings = AVCapturePhotoSettings()) {
        output.capturePhoto(with: settings, delegate: delegate!)
    }
}
