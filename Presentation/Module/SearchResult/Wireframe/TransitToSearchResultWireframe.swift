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

     func pushSearchResult(searchCondition: SearchTransitType)
}

extension TransitToSearchResultWireframe {

    func pushSearchResult(searchCondition: SearchTransitType) {
        let vc = SearchResultBuilder.build(searchCondition: searchCondition)
        // navigationを復活させておく
        self.viewController?.navigationController?.setNavigationBarHidden(false, animated: false)
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
