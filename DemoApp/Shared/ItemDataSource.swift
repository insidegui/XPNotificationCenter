//
//  ItemDataSource.swift
//  XPNCDemoApp
//
//  Created by Guilherme Rambo on 23/08/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

import Foundation

class ItemDataSource {
    
    let defaults = NSUserDefaults(suiteName: Constants.defaultsSuiteName)!
    var items: [String] {
        get {
            if let storedItems = defaults.objectForKey(Constants.itemsKey) as? [String] {
                return storedItems
            } else {
                let defaultItems = ["Item 0", "Item 1", "Item 2", "Item 3"]
                defaults.setObject(defaultItems, forKey: Constants.itemsKey)
                return defaultItems
            }
        }
        set {
            defaults.setObject(newValue as AnyObject, forKey: Constants.itemsKey)
            syncrhonize()
        }
    }
    
    func syncrhonize() {
        defaults.synchronize()
    }
    
}