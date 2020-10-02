//
//  UIColor+.swift
//  Presentation
//
//  Created by ichikawa on 2020/09/30.
//

import UIKit

extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1) {
        let hex = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hex)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            self.init(red: r, green: g, blue: b, alpha: alpha)
        }
        else {
            self.init(white: 1.0, alpha: 1.0)
        }
    }
}
