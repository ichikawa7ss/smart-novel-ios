//
//  NovelListTransitToNovelListWireframe.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 24/08/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit

protocol TransitToNovelListWireframe: AnyObject {

    var viewController: UIViewController? { get }

    // func pushNovelList()
    // func presentNovelList()
}

extension TransitToNovelListWireframe {

    //func pushNovelList() {
    //    let vc = NovelListBuilder.build()
    //    self.viewController?.navigationController?.pushViewController(vc, animated: true)
    //}

    //func presentNovelList() {
    //    let vc = NovelListBuilder.build()
    //    self.viewController?.present(vc, animated: true, completion: nil)
    //}
}

//protocol NovelListWireframeDelegate: AnyObject {}
