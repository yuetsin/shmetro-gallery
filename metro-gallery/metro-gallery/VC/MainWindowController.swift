//
//  MainWindowController.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/21.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Cocoa
import Localize_Swift

class MainWindowController: NSWindowController, L11nRefreshDelegate {

    override func windowDidLoad() {
        super.windowDidLoad()
        flushUILocalization()
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    @IBOutlet weak var windowToolBar: NSToolbar!
    @IBOutlet weak var prefToolBarItem: NSToolbarItem!
    
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
    
    func flushUILocalization() {
        prefToolBarItem.label = genLocalizationString(zhHans: "偏好设定", en: "Preferences")
        self.window?.title = genLocalizationString(zhHans: "上海轨道交通", en: "Shanghai Metro")
        (self.contentViewController as! ViewController).flushUILocalization()
    }
}
