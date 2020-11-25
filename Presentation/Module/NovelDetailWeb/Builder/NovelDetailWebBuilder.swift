//
//  NovelDetailWebNovelDetailWebBuilder.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 03/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit

enum NovelDetailWebBuilder {

    static func build(url: URL) -> UIViewController {
        let viewController = NovelDetailWebViewController.instantiate()
        let wireframe = NovelDetailWebWireframeImpl()

        wireframe.viewController = viewController

        let viewModel = NovelDetailWebViewModel(
            extra: .init(
                wireframe: wireframe
            )
        )

        viewController.viewModel = viewModel
        viewController.requestURL = url

        return viewController
    }
}

