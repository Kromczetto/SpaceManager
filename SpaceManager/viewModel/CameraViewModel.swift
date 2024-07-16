//
//  CameraViewModel.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 16/07/2024.
//

import Foundation
import AVFoundation

class CameraViewModel: ObservableObject {
    @Published var isTaken: Bool = false
    @Published var session = AVCaptureSession()
    @Published var alert: Bool = false
    @Published var output = AVCapturePhotoOutput()
    
    func checkPermission(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .authorized:
            setUp()
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: {(status) in
                if(status){
                    self.setUp()
                }
            })
        case .denied:
            self.alert.toggle()
            return
        default:
            return
        }
    }
    func setUp(){
        do{
            self.session.beginConfiguration()
            let device = AVCaptureDevice.default(.builtInDualCamera,for: .video, position: .front)
            let input = try AVCaptureDeviceInput(device: device!)
            
            if(self.session.canAddInput(input)){
                self.session.addInput(input)
            }
            if(self.session.canAddOutput(self.output)){
                self.session.addOutput(self.output)
            }
            self.session.commitConfiguration()
        }catch{
            print("Problem with camera")
        }
    }
}
