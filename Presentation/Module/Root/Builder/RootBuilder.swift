//
//  RootRootBuilder.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 21/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit

public enum RootBuilder {

    public static func build() -> UIViewController {
        let viewController = RootViewController.instantiate()
        let wireframe = RootWireframeImpl()

        wireframe.viewController = viewController

        let viewModel = RootViewModel(
            extra: .init(
                wireframe: wireframe
            )
        )

        viewController.viewModel = viewModel

        return viewController
    }
}

