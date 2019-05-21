//
//  UILanguageInit.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/21.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Foundation
import Localize_Swift

func initUILanguage() {
    Localize.setCurrentLanguage(SuperManager.UILanguage.rawValue == 0 ? "zh-Hans" : "en")
}
