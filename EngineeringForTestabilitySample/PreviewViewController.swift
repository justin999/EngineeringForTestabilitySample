//
//  PreviewViewController.swift
//  EngineeringForTestabilitySample
//
//  Created by Koichi Sato on 2018/01/05.
//  Copyright © 2018 justin999. All rights reserved.
//

import UIKit

class Document {
    var identifier: String
    init(identifier: String) {
        self.identifier = identifier
    }
}

protocol URLOpening {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL, options: [String: Any], completionHandler: ((Bool) -> Void)?)
}

extension UIApplication: URLOpening {
    // Nothing needed here!
}

class DocumentOpener {
    let urlOpener: URLOpening
    init(urlOpener: URLOpening = UIApplication.shared) {
        self.urlOpener = urlOpener
    }
    
    enum OpenMode: String {
        case view
        case edit
    }
    func open(_ document: Document, mode: OpenMode) {
        let modeString = mode.rawValue
        let url = URL(string: "myappscheme://open?id=\(document.identifier)&mode=\(modeString)")!
        
        if urlOpener.canOpenURL(url) {
            urlOpener.open(url, options: [:], completionHandler: nil)
        } else {
            handleURLError()
        }
    }
    
    // MARK: private
    private func handleURLError() {
        print("Handling URL Error")
    }
}

class PreviewViewController: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var button: UIButton!
    var document = Document(identifier: "tmp")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openTapped(_ sender: Any) {
        let mode: String
        switch segmentedControl.selectedSegmentIndex {
        case 0: mode = "view"
        case 1: mode = "edit"
        default: fatalError("Impossible case")
        }
        let url = URL(string: "myappscheme://open?id=\(document.identifier)&mode=\(mode)")!
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            handleURLError()
        }
    }

    // Untestable Version
//    func openTapped_Untestable(_ sender: Any) {
//        let mode: String
//        switch segmentedControl.selectedSegmentIndex {
//        case 0: mode = "view"
//        case 1: mode = "edit"
//        default: fatalError("Impossible case")
//        }
//        let url = URL(string: "myappscheme://open?id=\(document.identifier)&mode=\(mode)")
//
//        if UIApplication.shared.canOpenURL(url) {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        } else {
//            handleURLError()
//        }
//    }
    
    // MARK: private
    private func handleURLError() {
        print("Handling URL Error")
    }

}
