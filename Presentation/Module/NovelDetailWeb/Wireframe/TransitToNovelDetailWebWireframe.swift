//
//  NovelDetailWebTransitToNovelDetailWebWireframe.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 03/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit

protocol TransitToNovelDetailWebWireframe: AnyObject {

    var viewController: UIViewController? { get }

     func pushNovelDetailWeb()
}

extension TransitToNovelDetailWebWireframe {

    func pushNovelDetailWeb() {
        let vc = NovelDetailWebBuilder.build()
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}

//protocol NovelDetailWebWireframeDelegate: AnyObject {}
