//
//  DiscCache.swift
//  EngineeringForTestabilitySample
//
//  Created by Koichi Sato on 2018/01/06.
//  Copyright © 2018 justin999. All rights reserved.
//

import Foundation
import UIKit

protocol CleanupPolicy {
    func itemsToRemove(from items: Set<OnDiskCache.Item> ) -> Set<OnDiskCache.Item>
}

struct MaxSizeCleanupPolicy: CleanupPolicy {
    let maxSize: Int
    func itemsToRemove(from items: Set<OnDiskCache.Item>) -> Set<OnDiskCache.Item> {
        var itemsToRemove = Set<OnDiskCache.Item>()
        var cumulativeSize = 0
        
        let sortedItems = items.sorted { $0.age < $1.age }
        for item in sortedItems {
            cumulativeSize += item.size
            if cumulativeSize > maxSize {
                itemsToRemove.insert(item)
            }
        }
        return itemsToRemove
    }
}

class OnDiskCache {
    struct Item {
        var path: String
        var age: TimeInterval
        var size: Int
    }
    
    var currentItems: Set<Item> = Set([Item(path: "pathToFile", age: 10, size: 3)])

    func cleanCache(policy: CleanupPolicy) throws {
        let itemsToRemove = policy.itemsToRemove(from: self.currentItems)
        for item in itemsToRemove {
            try FileManager.default.removeItem(atPath: item.path)
        }
    }
    
    func cleanCache_Untestable(maxSize: Int) throws {
        let sortedItems = self.currentItems.sorted { $0.age < $1.age }

        var cumulativeSize = 0
        for item in sortedItems {
            cumulativeSize += item.size
            if cumulativeSize > maxSize {
                try FileManager.default.removeItem(atPath: item.path)
            }
        }
    }
}

extension OnDiskCache.Item: Hashable, Equatable {
    var hashValue: Int { return 1 }
    public static func ==(lhs: OnDiskCache.Item, rhs: OnDiskCache.Item) -> Bool {
        return lhs.path == rhs.path && lhs.age == rhs.age && lhs.size == rhs.size
    }
}
