//
//  MainWindowController.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/21.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Cocoa
import Localize_Swift

class MainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    lazy var prefPopOver: NSPopover = {
        let prefPopOver = NSPopover()
        prefPopOver.behavior = .semitransient
        return prefPopOver
    }()
    
    @IBOutlet weak var windowToolBar: NSToolbar!
    @IBOutlet weak var prefToolBarItem: NSToolbarItem!
    
    private var popoverVisible: Bool {
        get { return prefPopOver.isShown }
    }

    @IBAction func openPreferencePanel(_ sender: NSToolbarItem) {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("PreferenceWC")) as! NSWindowController
        
        if let window = windowController.window {
            self.window?.beginSheet(window, completionHandler: { _ in
                (self.window?.contentViewController as! ViewController).forceReRender()
            })
        }
    }
}
