//
//  BrowserWireframe.swift
//  Presentation
//
//  Created by ichikawa on 2020/10/05.
//

import UIKit

protocol TransitToBrowserWireframe {
    func transit(by url: URL)
}

extension TransitToBrowserWireframe {

    func transit(by url: URL) {
        if UIApplication.shared.canOpenURL(url)  {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
