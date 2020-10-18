//
//  BaseView.swift
//  Presentation
//
//  Created by ichikawa on 2020/10/14.
//

import Foundation
import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    internal func commonInit() {
        guard let view = Bundle.loadView(instance: self) else {
            return
        }
        self.addSubview(view)
    }
}
