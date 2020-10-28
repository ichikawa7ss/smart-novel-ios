//
//  SplashSplashWireframe.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 28/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit

protocol SplashWireframe: TransitToRootWireframe {}

final class SplashWireframeImpl: SplashWireframe {

    weak var viewController: UIViewController?
}
