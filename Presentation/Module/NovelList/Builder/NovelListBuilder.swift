//
//  NovelListNovelListBuilder.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 24/08/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit

public enum NovelListBuilder {

    public static func build() -> UIViewController {
        let viewController = NovelListViewController.instantiate()
        let wireframe = NovelListWireframeImpl()

        wireframe.viewController = viewController

        let viewModel = NovelListViewModel(
            extra: .init(
                wireframe: wireframe
            )
        )

        viewController.viewModel = viewModel

        return viewController
    }
}
