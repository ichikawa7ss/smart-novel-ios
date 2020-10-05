//
//  NovelListNovelListWireframe.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 24/08/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit

protocol NovelListWireframe: TransitToNovelDetailWebWireframe {}

final class NovelListWireframeImpl: NovelListWireframe {

    weak var viewController: UIViewController?
}
