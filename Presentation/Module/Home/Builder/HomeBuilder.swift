//
//  HomeBuilder.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 24/08/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit
import Domain

public enum HomeBuilder {

    public static func build() -> UIViewController {
        let viewController = HomeViewController.instantiate()
        let wireframe = HomeWireframeImpl()

        wireframe.viewController = viewController

        let viewModel = HomeViewModel(
            extra: .init(
                wireframe: wireframe,
                useCase: HomeUseCaseProvider.provide()
            )
        )

        viewController.viewModel = viewModel

        return viewController
    }
}

