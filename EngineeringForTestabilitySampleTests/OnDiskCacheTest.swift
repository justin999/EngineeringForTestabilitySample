//
//  OnDiskCacheTest.swift
//  EngineeringForTestabilitySampleTests
//
//  Created by Koichi Sato on 2018/01/06.
//  Copyright © 2018 justin999. All rights reserved.
//

import XCTest
@testable import EngineeringForTestabilitySample

class OnDiskCacheTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMaxSizeCleanupPolicy() {
        let inputItems = Set([
            OnDiskCache.Item(path: "/item1", age: 5, size: 7),
            OnDiskCache.Item(path: "/item2", age: 3, size: 2),
            OnDiskCache.Item(path: "/item3", age: 9, size: 9)
            ])
        
        let outputItems = MaxSizeCleanupPolicy(maxSize: 10).itemsToRemove(from: inputItems)
        
        XCTAssertEqual(outputItems, [OnDiskCache.Item(path: "/item3", age: 9, size: 9)])
    }
}
