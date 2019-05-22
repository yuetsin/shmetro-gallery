//
//  MenuWithSeparator.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/22.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Cocoa

class MenuWithSeparator: NSMenu {
    override func addItem(withTitle string: String, action selector: Selector?, keyEquivalent charCode: String) -> NSMenuItem {
        if string == "---TIMETABLE--ITEM--SEPARATOR---" {
            let separator = NSMenuItem.separator()
            self.addItem(separator)
            return separator
        }
        return super.addItem(withTitle: string, action: selector, keyEquivalent: charCode)
    }
    
    override func insertItem(withTitle string: String, action selector: Selector?, keyEquivalent charCode: String, at index: Int) -> NSMenuItem {
        if string == "---TIMETABLE--ITEM--SEPARATOR---" {
            let separator = NSMenuItem.separator()
            self.insertItem(separator, at: index)
            return separator
        }
        return super.insertItem(withTitle: string, action: selector, keyEquivalent: charCode, at: index)
    }
}
