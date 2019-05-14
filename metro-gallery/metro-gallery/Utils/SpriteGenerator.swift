//
//  SpriteGenerator.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/14.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Cocoa
import Foundation

func roundCorners(image: NSImage, width: CGFloat = 192, height: CGFloat = 192) -> NSImage {
    let xRad = width / 2
    let yRad = height / 2
    let existing = image
    let esize = existing.size
    let newSize = NSMakeSize(esize.width, esize.height)
    let composedImage = NSImage(size: newSize)
    
    composedImage.lockFocus()
    let ctx = NSGraphicsContext.current
    ctx?.imageInterpolation = NSImageInterpolation.high
    
    let imageFrame = NSRect(x: 0, y: 0, width: width, height: height)
    let clipPath = NSBezierPath(roundedRect: imageFrame, xRadius: xRad, yRadius: yRad)
    clipPath.windingRule = NSBezierPath.WindingRule.evenOdd
    clipPath.addClip()
    
    let rect = NSRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    
    image.draw(at: NSZeroPoint, from: rect, operation: NSCompositingOperation.sourceOver, fraction: 1)
    composedImage.unlockFocus()
    
    return composedImage
}
