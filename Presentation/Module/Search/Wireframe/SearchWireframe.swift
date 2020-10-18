//
//  SearchSearchWireframe.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 14/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit

protocol SearchWireframe: AnyObject {}

final class SearchWireframeImpl: SearchWireframe {

    weak var viewController: UIViewController?
}
