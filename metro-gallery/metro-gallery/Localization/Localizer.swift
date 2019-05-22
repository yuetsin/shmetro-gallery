//
//  Localizer.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/22.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Foundation

func genLocalizationString(zhHans: String, en: String) -> String {
    if SuperManager.UILanguage == .chinese {
        return zhHans
    }
    
    return en
}
