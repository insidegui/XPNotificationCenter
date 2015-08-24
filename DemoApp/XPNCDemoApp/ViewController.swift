//
//  ViewController.swift
//  XPNCDemoApp
//
//  Created by Guilherme Rambo on 23/08/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let dataSource = ItemDataSource()
    
    var items: [String] {
        get {
            return dataSource.items
        }
        set {
            dataSource.items = newValue
        }
    }
    
    @IBAction func addItem(sender: AnyObject) {
        var mutableItems = items
        mutableItems.append("Item \(items.count+1)")
        items = mutableItems
        
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: items.count-1, inSection: 0)], withRowAnimation: .Left)
        
        // send a notification to the watch extension so it knows the item list has changed
        XPNotificationCenter.defaultCenter.postNotificationName(NotificationNames.itemListAdded, sender: self)
    }
    
    func removeItem(index: Int) {
        var mutableItems = items
        mutableItems.removeAtIndex(index)
        items = mutableItems
        
        tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .Right)

        // send a notification to the watch extension so it knows the item list has changed
        XPNotificationCenter.defaultCenter.postNotificationName(NotificationNames.itemListDeleted, sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        XPNotificationCenter.defaultCenter.removeObserver(self)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("row") as! UITableViewCell
        
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            removeItem(indexPath.row)
        }
    }

}

