//
//  RowController.swift
//  XPNCDemoApp
//
//  Created by Guilherme Rambo on 23/08/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

import Foundation
import WatchKit

class RowController: NSObject {
   
    var item: String! {
        didSet {
            titleLabel.setText(item)
        }
    }
    
    @IBOutlet weak var titleLabel: WKInterfaceLabel!
}
