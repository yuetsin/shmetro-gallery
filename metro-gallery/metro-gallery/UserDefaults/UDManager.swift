//
//  UDManager.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/21.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Foundation

class preferenceKeys {
    static let languageKey = "UILanguageKey"
    static let useAccessibilityKey = "UseAccessibilityKey"
}

let languageIndexList: [Language] = [.chinese, .english]

func initPreferences() {
    UserDefaults.standard.register(defaults: [preferenceKeys.languageKey : Language.chinese.rawValue])
    UserDefaults.standard.register(defaults: [preferenceKeys.useAccessibilityKey : false])
}

func loadPreferences() {
    let defaults = UserDefaults.standard
    SuperManager.UILanguage = Language(rawValue: defaults.integer(forKey: preferenceKeys.languageKey)) ?? .chinese
    SuperManager.acessibilityMode = defaults.bool(forKey: preferenceKeys.useAccessibilityKey)
}

func setPreferences() {
    let language = SuperManager.UILanguage
    let useAccessibility = SuperManager.acessibilityMode
    
    let defaults = UserDefaults.standard
    defaults.set(language.rawValue, forKey: preferenceKeys.languageKey)
    defaults.set(useAccessibility, forKey: preferenceKeys.useAccessibilityKey)
}
