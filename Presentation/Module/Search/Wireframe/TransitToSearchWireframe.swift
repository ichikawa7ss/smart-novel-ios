//
//  SearchTransitToSearchWireframe.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 14/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit

protocol TransitToSearchWireframe: AnyObject {

    var viewController: UIViewController? { get }

    // func pushSearch()
    // func presentSearch()
}

extension TransitToSearchWireframe {

    //func pushSearch() {
    //    let vc = SearchBuilder.build()
    //    self.viewController?.navigationController?.pushViewController(vc, animated: true)
    //}

    //func presentSearch() {
    //    let vc = SearchBuilder.build()
    //    self.viewController?.present(vc, animated: true, completion: nil)
    //}
}

//protocol SearchWireframeDelegate: AnyObject {}
