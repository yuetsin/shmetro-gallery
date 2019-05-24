//
//  LocalizationRefreshDelegate.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/22.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Foundation

protocol L11nRefreshDelegate {
    func flushUILocalization() -> ()
}

protocol StatusOperatingDelegate {
    func setStatusIcon(_: OperatingStatus) -> ()
}
