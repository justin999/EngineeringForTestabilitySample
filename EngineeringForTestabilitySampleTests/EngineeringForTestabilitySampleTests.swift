//
//  EngineeringForTestabilitySampleTests.swift
//  EngineeringForTestabilitySampleTests
//
//  Created by Koichi Sato on 2018/01/05.
//  Copyright © 2018 justin999. All rights reserved.
//

import XCTest
@testable import EngineeringForTestabilitySample

class EngineeringForTestabilitySampleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testArraySorting() {
        let input = [1, 7, 6, 3, 10]
        let output = input.sorted()
        
        XCTAssertEqual(output, [1, 3, 6, 7, 10])
    }
    
}
