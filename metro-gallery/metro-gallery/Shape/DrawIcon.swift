//
//  DrawIcon.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/15.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Cocoa
import Foundation
import FlexibleImage

func drawIconByColor(_ color: NSColor) -> NSImage? {
    if SuperManager.acessibilityMode {
        return nil
    }
    return NSImage.circle(
        color: NSColor.blue,
        size: CGSize(width: 100, height: 100)
        )!
        .adjust()
        .offset(CGPoint(x: 30, y: 0))
        .margin(EdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        .padding(EdgeInsets(top: 25, left: 25, bottom: 25, right: 25))
        .normal(color: color)
        .image()!
        .adjust()
        .background(color: NSColor.clear)
        .image()
}
