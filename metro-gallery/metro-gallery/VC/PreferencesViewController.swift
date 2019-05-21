//
//  PreferencesViewController.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/21.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Cocoa

class PreferencesViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        displayLanguageIsChinese = SuperManager.UILanguage == .chinese ? .on : .off
        displayLanguageIsEnglish = displayLanguageIsChinese == .on ? .off : .on
        
        doNotUseColorDistinguish = SuperManager.acessibilityMode ? .on : .off
    }
    
    @objc dynamic var displayLanguageIsChinese: NSButton.StateValue = .on
    @objc dynamic var displayLanguageIsEnglish: NSButton.StateValue = .off
    @objc dynamic var doNotUseColorDistinguish: NSButton.StateValue = .off
//    @objc dynamic var alwaysAccessOnlineData: NSButton.StateValue = .off
    
    @IBAction func closePrefWindow(_ sender: NSButton) {
        setPreferences()
        self.view.window?.close()
    }
    
    @IBAction func languageSwitched(_ sender: NSButtonCell) {
        
        if sender.tag == 0 {
            displayLanguageIsChinese = .on
            displayLanguageIsEnglish = .off
        } else {
            displayLanguageIsChinese = .off
            displayLanguageIsEnglish = .on
        }
        updateSuperManager()
    }
    
    @IBAction func useColorToDist(_ sender: NSButton) {
        updateSuperManager()
    }
    
//    @IBAction func useUnstableOnline(_ sender: NSButton) {
//        updateSuperManager()
//    }
//
//    @IBAction func goToOfficialWebsite(_ sender: NSButton) {
//        if let url = URL(string: "http://www.shmetro.com"), NSWorkspace.shared.open(url) {
//            // successfully opened
//        } else {
//            showErrorMessage(errorMsg: "未能打开网页。")
//        }
//    }
    
    fileprivate func updateSuperManager() {
        SuperManager.UILanguage = displayLanguageIsChinese == .on ? .chinese : .english
        SuperManager.acessibilityMode = doNotUseColorDistinguish == .on
//        SuperManager.requestMode = alwaysAccessOnlineData == .on ? .online : .offline
        
        setPreferences()
    }
}
