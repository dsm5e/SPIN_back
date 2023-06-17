//
//  DocVM.swift
//  Spin
//
//  Created by dsm 5e on 06.05.2023.
//

import Foundation
import SwiftUI
import VisionKit

class DocVM: ObservableObject {
    @Published var clientData: [ClientModel] = []
    @Published var sortedClient: [ClientModel] = []
    @Published var selectedItem: ClientModel?
    
    init() {
        getData()
        self.selectedItem = selectedItem
    }
    
    func getData() {
        let client1 = ClientModel(name: "Александр", secondName: "евдокименко", number: "+7890323111", documentLoad: false, doucmentCount: 1)
        let client2 = ClientModel(name: "Andrey", secondName: "vasdads", number: "+7890323111", documentLoad: false, doucmentCount: 2)
        let client3 = ClientModel(name: "Oleg", secondName: "Kekovich", number: "+7890323111", documentLoad: true, doucmentCount: 1)
        
        clientData.append(contentsOf:
                            [client1,
                             client2,
                             client3
                            ])
    }
}

struct DocScan: UIViewControllerRepresentable {
    
    @Binding var results: [UIImage]
    let cancelled: (() -> ())?
    let failed: ((Error) -> ())?
    
    init(results: Binding<[UIImage]>, cancelled: (()->())?, failedWith failed: ((Error) -> ())?) {
        self.cancelled = cancelled
        self.failed = failed
        self._results = results
    }
    
    //Handles updates from the Delegate to SwiftUI
    class ScannerViewCoordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        let visionView: DocScan
        init(withVisionView visionView: DocScan) {
            self.visionView = visionView
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            for pageIndex in 0..<scan.pageCount {
                let image = scan.imageOfPage(at: pageIndex)
                visionView.results.append(image)
            }
            controller.dismiss(animated: true)
        }
        
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            visionView.cancelled?()
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            visionView.failed?(error)
        }
    }
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let scannerViewController = VNDocumentCameraViewController()
        scannerViewController.delegate = context.coordinator
        return scannerViewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        //nothing to do here
    }
    
    func makeCoordinator() -> ScannerViewCoordinator {
        return ScannerViewCoordinator(withVisionView: self)
    }
}


