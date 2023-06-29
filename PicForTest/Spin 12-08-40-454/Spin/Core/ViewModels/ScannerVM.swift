//
//  QRScannerDelegate.swift
//  Spin
//
//  Created by Golyakovph on 26.04.2023.
//

import SwiftUI
import AVKit

enum ScanerCameraPermission: String {
    case idle = "Not Determined"
    case approved = "Access Granted"
    case denided = "Access Denied"
}

class ScannerVM: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    @Published var scannedCode: String?
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metaObject = metadataObjects.first {
            guard let readableObject = metaObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let Code = readableObject.stringValue else { return }
            print(Code)
            scannedCode = Code
        }
    }
}


