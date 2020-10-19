//
//  SearchResultTransitToSearchResultWireframe.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 19/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit

protocol TransitToSearchResultWireframe: AnyObject {

    var viewController: UIViewController? { get }

    // func pushSearchResult()
    // func presentSearchResult()
}

extension TransitToSearchResultWireframe {

    //func pushSearchResult() {
    //    let vc = SearchResultBuilder.build()
    //    self.viewController?.navigationController?.pushViewController(vc, animated: true)
    //}

    //func presentSearchResult() {
    //    let vc = SearchResultBuilder.build()
    //    self.viewController?.present(vc, animated: true, completion: nil)
    //}
}

//protocol SearchResultWireframeDelegate: AnyObject {}
