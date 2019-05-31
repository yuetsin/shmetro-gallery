//
//  MainWindowController.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/21.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Cocoa
import Localize_Swift

class MainWindowController: NSWindowController, L11nRefreshDelegate, StatusOperatingDelegate {

    override func windowDidLoad() {
        super.windowDidLoad()
        flushUILocalization()
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        (self.contentViewController as! ViewController).delegate = self
    }
    
    @IBOutlet weak var windowToolBar: NSToolbar!
    @IBOutlet weak var prefToolBarItem: NSToolbarItem!
    
    @IBOutlet weak var statusIcon: NSButton!
    @IBOutlet weak var statusToolBarItem: NSToolbarItem!
    @IBOutlet weak var stationSearchField: NSSearchField!
    @IBOutlet weak var updateStatusToolBarItem: NSToolbarItem!
    
    @IBAction func openPreferencePanel(_ sender: NSToolbarItem) {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("PreferenceWC")) as! NSWindowController
        (windowController.contentViewController as! PreferencesViewController).delegate = self
        if let window = windowController.window {
            self.window?.beginSheet(window, completionHandler: { _ in
                (self.window?.contentViewController as! ViewController).forceReRender()
            })
        }
    }
    
    @IBAction func searchTapped(_ sender: NSSearchField) {
        
        let requestedString = sender.stringValue
        
        if requestedString != "" {
            (self.window?.contentViewController as! ViewController).searchStation(requestedString)
            stationSearchField.recentSearches.append(requestedString)
        }
    }
    
    @IBAction func clickedOperatingStatus(_ sender: NSButton) {
        (self.window?.contentViewController as! ViewController).clickStatusDetail()
    }
    
    @IBAction func updateOperatingStatus(_ sender: NSToolbarItem) {
        (self.window?.contentViewController as! ViewController).flushOperatingStatus()
    }
    
    @IBAction func showOpStatusItem(_ sender: NSToolbarItem) {
        (self.window?.contentViewController as! ViewController).clickStatusDetail()
    }
    
    func setStatusIcon(_ stat: OperatingStatus) {
        if stat == .normal {
            statusIcon.image = NSImage(named: "NSStatusAvailable")
        } else if stat == .abnormal {
            statusIcon.image = NSImage(named: "NSStatusUnavailable")
        } else {
            statusIcon.image = NSImage(named: "NSStatusNone")
        }
    }
    
    func flushUILocalization() {
        prefToolBarItem.label = genLocalizationString(zhHans: "偏好设定", en: "Preferences")
        statusToolBarItem.label = genLocalizationString(zhHans: "运营情况", en: "Operating Status")
        updateStatusToolBarItem.label = genLocalizationString(zhHans: "刷新运营状态", en: "Refresh Status")
        stationSearchField.placeholderString = genLocalizationString(zhHans: "站点名称", en: "Station Name")
        self.window?.title = genLocalizationString(zhHans: "上海轨道交通", en: "Shanghai Metro")
        (self.contentViewController as! ViewController).flushUILocalization()
    }
}

