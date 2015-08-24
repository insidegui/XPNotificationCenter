//
//  InterfaceController.swift
//  XPNCDemoApp WatchKit Extension
//
//  Created by Guilherme Rambo on 23/08/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var table: WKInterfaceTable!
    
    let dataSource = ItemDataSource()
    
    var items: [String] {
        get {
            return dataSource.items
        }
        set {
            dataSource.items = newValue
        }
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        XPNotificationCenter.defaultCenter.addObserver(self, name: NotificationNames.itemListAdded) { note in
            println("WatchKit extension received notification: \(note)")
            
            self.updateTable()
            self.table.scrollToRowAtIndex(self.items.count-1)
        }
        XPNotificationCenter.defaultCenter.addObserver(self, name: NotificationNames.itemListDeleted) { note in
            println("WatchKit extension received notification: \(note)")
            
            self.updateTable()
        }
    }
    
    override func willActivate() {
        updateTable()
        
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func updateTable() {
        dataSource.syncrhonize()
        
        table.setNumberOfRows(items.count, withRowType: "row")
        var index = 0
        for item in items {
            let rowController = table.rowControllerAtIndex(index) as! RowController
            rowController.item = item
            index++
        }
    }

}
