//
//  PreviewViewControllerTest.swift
//  EngineeringForTestabilitySampleTests
//
//  Created by Koichi Sato on 2018/01/06.
//  Copyright © 2018 justin999. All rights reserved.
//

import XCTest
@testable import EngineeringForTestabilitySample

class PreviewViewControllerTest: XCTestCase {
    class MockURLOpener: URLOpening {
        var canOpen = false
        var openedURL: URL?
        
        func canOpenURL(_ url: URL) -> Bool {
            return canOpen
        }
        
        func open(_ url: URL, options: [String : Any], completionHandler: ((Bool) -> Void)?) {
            openedURL = url
        }
        
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // test that can't be done
    func testOpenDocumentURLWhenButtonIsTapped() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Preview") as! PreviewViewController
        controller.loadViewIfNeeded()
        controller.segmentedControl.selectedSegmentIndex = 1
        controller.document = Document(identifier: "TheID")
        
        controller.openTapped(controller.button)
        // ??? what to assert?
    }
    
    func testDocumentOpenerWhenItCanOpen() {
        let urlOpener = MockURLOpener()
        urlOpener.canOpen = true
        let documentOpener = DocumentOpener(urlOpener: urlOpener)
        
        documentOpener.open(Document(identifier: "TheID"), mode: .edit)
        
        XCTAssertEqual(urlOpener.openedURL, URL(string: "myappscheme://open?id=TheID&mode=edit")!)
    }
    
}
