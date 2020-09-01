//
//  UIView+.swift
//  Presentation
//
//  Created by ichikawa on 2020/09/01.
//

import UIKit

// MARK: - nib
extension UIView {

    static var nib: UINib {
        let bundle = Bundle(for: self.self)
        return UINib(nibName: self.className, bundle: bundle)
    }

    var nib: UINib {
        return type(of: self).nib
    }
}

// MARK: - class name
extension UIView {

    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}