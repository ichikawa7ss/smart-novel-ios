//
//  RootRootWireframe.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 21/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit

protocol RootWireframe: AnyObject {}

final class RootWireframeImpl: RootWireframe {

    weak var viewController: UIViewController?
}
