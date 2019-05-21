//
//  LocalizationUtil.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/21.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Foundation

extension Bundle {
    private static var bundle: Bundle!
    
    static let languageCode = ["zh-Hans", "en"]
    
    public static func localizedBundle() -> Bundle! {
        if bundle == nil {
            let appLang = languageCode[UserDefaults.standard.integer(forKey: preferenceKeys.languageKey)]
            let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
            bundle = Bundle(path: path!)
        }
        
        return bundle
    }
    
    public static func setLanguage(languageId: Int) {
        let path = Bundle.main.path(forResource: languageCode[languageId], ofType: "lproj")
        bundle = Bundle(path: path!)
    }
}

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.localizedBundle(), value: "", comment: "")
    }
    
    func localizeWithFormat(arguments: CVarArg...) -> String{
        return String(format: self.localized(), arguments: arguments)
    }
}
