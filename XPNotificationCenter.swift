//
//  XPNotificationCenter.swift
//  XPNCDemoApp
//
//  Created by Guilherme Rambo on 23/08/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

import Foundation

class XPNotification: NSObject, Printable {
    
    var identifier: String
    var name: String
    
    init(name: String) {
        self.identifier = NSUUID().UUIDString
        self.name = name
        
        super.init()
    }
    
    override var description: String {
        get {
            return "XPNotification<\(identifier)-\(name)>"
        }
    }
    
}

private let _defaultXPNotificationCenter = XPNotificationCenter()

class XPNotificationCenter {
    
    class var defaultCenter: XPNotificationCenter {
        get {
            return _defaultXPNotificationCenter
        }
    }
    
    func addObserver(observer: AnyObject, name: String, callback: (note: XPNotification) -> ()) {
        // this block will become the notification's callback
        let callbackBlock: @objc_block (CFNotificationCenter!, CFString!, UnsafePointer<Void>, CFDictionary!) -> Void = { center, name, _, _ in
            let note = XPNotification(name: name as String)
            callback(note: note)
        }
        // convert the block into a function pointer which can be passed to CFNotificationCenterAddObserver
        let callbackImp = imp_implementationWithBlock(unsafeBitCast(callbackBlock, AnyObject.self))
        let callbackPtr = unsafeBitCast(callbackImp, CFNotificationCallback.self)
        
        // convert the observer into a pointer which can be passed to CFNotificationCenterAddObserver
        let observerPtr: UnsafePointer<Void> = unsafeBitCast(observer, UnsafePointer<Void>.self)
        
        // register the observation
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), observerPtr, callbackPtr, name as CFString, nil, .Drop)
    }
    
    func postNotificationName(name: String, sender: AnyObject) {
        let senderPtr = unsafeBitCast(sender, UnsafePointer<Void>.self)
        
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), name as CFString, senderPtr, nil, UInt8(1))
    }
    
    func removeObserver(observer: AnyObject, name: String?) {
        let theObserver = unsafeBitCast(observer, UnsafePointer<Void>.self)
        
        if name == nil {
            CFNotificationCenterRemoveEveryObserver(CFNotificationCenterGetDarwinNotifyCenter(), theObserver)
        } else {
            CFNotificationCenterRemoveObserver(CFNotificationCenterGetDarwinNotifyCenter(), theObserver, name as! CFString, nil)
        }
    }
    
    func removeObserver(observer: AnyObject) {
        removeObserver(observer, name: nil)
    }
    
}