//
//  SplashSplashBuilder.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 28/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit
import Domain

public enum SplashBuilder {

    static public func build() -> UIViewController {
        let viewController = SplashViewController.instantiate()
        let wireframe = SplashWireframeImpl()

        wireframe.viewController = viewController

        let viewModel = SplashViewModel(
            extra: .init(
                wireframe: wireframe,
                useCase: SplashUseCaseProvider.provide()
            )
        )

        viewController.viewModel = viewModel

        return viewController
    }
}

