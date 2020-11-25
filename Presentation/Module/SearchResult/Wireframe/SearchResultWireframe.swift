//
//  SearchResultSearchResultWireframe.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 19/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit

protocol SearchResultWireframe: TransitToNovelDetailWebWireframe {}

final class SearchResultWireframeImpl: SearchResultWireframe {

    weak var viewController: UIViewController?
}
