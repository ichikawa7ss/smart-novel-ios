//
//  Bundle+.swift
//  Presentation
//
//  Created by ichikawa on 2020/10/14.
//

import Foundation
import UIKit

extension Bundle {

    static func loadView(instance: UIView) -> UIView? {
        let t = type(of: instance)
        let bundle = Bundle(for: t)
        let nib = UINib(nibName: String(describing: t), bundle: bundle)
        return nib.instantiate(withOwner: instance, options: nil).first as? UIView
    }
}
