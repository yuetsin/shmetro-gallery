//
//  PreferencesViewController.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/21.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Cocoa
import Localize_Swift

class PreferencesViewController: NSViewController, L11nRefreshDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        flushUILocalization()
        // Do view setup here.
        displayLanguageIsChinese = SuperManager.UILanguage == .chinese ? .on : .off
        displayLanguageIsEnglish = displayLanguageIsChinese == .on ? .off : .on
        
        doNotUseColorDistinguish = SuperManager.acessibilityMode ? .on : .off
    }
    
    var delegate: L11nRefreshDelegate?
    
    @objc dynamic var displayLanguageIsChinese: NSButton.StateValue = .on
    @objc dynamic var displayLanguageIsEnglish: NSButton.StateValue = .off
    @objc dynamic var doNotUseColorDistinguish: NSButton.StateValue = .off
//    @objc dynamic var alwaysAccessOnlineData: NSButton.StateValue = .off
    
    
    @IBOutlet weak var primaryTitleText: NSTextField!
    @IBOutlet weak var languagePromptText: NSTextField!
    @IBOutlet weak var languageSecondaryText: NSTextField!
    @IBOutlet weak var accessibilityPromptText: NSTextField!
    @IBOutlet weak var accessibilityCheckBox: NSButton!
    @IBOutlet weak var accessibilitySecondaryText: NSTextField!
    @IBOutlet weak var copyrightTextField: NSTextField!
    @IBOutlet weak var OKButton: NSButton!
    
    
    func flushUILocalization() {
        primaryTitleText.stringValue = genLocalizationString(zhHans: "偏好设定", en: "Preferences")
        languagePromptText.stringValue = genLocalizationString(zhHans: "显示语言：", en: "UI Language:")
        languageSecondaryText.stringValue = genLocalizationString(zhHans: "需要重新打开线路详情窗口来应用新的界面显示语言。", en: "The line detail window needs to be reopened to apply the new interface display language.")
        accessibilityPromptText.stringValue = genLocalizationString(zhHans: "辅助功能：", en: "Accessibility:")
        accessibilityCheckBox.title = genLocalizationString(zhHans: "不使用颜色区分线路", en: "Do not use color to distinguish metro lines")
        
        accessibilitySecondaryText.stringValue = genLocalizationString(zhHans: "打开此开关后，将不绘制标识色来区分地铁线路。将绘制一些辅助符号来标记线路。", en: "With this switch turning on, the metro line primary color will not be drawn to distinguish metro lines.")
        
        copyrightTextField.stringValue = genLocalizationString(zhHans: "Copyright © 2008 - 2019 上海申通地铁集团有限公司 版权所有 All Rights Reserved.", en: "Copyright © 2008 - 2019 Shanghai Shentong Metro Group Co., Ltd. All Rights Reserved.")
        
        OKButton.title = genLocalizationString(zhHans: "好", en: "OK")
    }
    
    @IBAction func closePrefWindow(_ sender: NSButton) {
        setPreferences()
        delegate?.flushUILocalization()
        self.view.window?.sheetParent?.endSheet(self.view.window!)
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
        flushUILocalization()
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
        initUILanguage()
    }
}
