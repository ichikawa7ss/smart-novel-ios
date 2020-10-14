//
//  SearchSearchBuilder.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 14/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit

public enum SearchBuilder {

    public static func build() -> UIViewController {
        let viewController = SearchViewController.instantiate()
        let wireframe = SearchWireframeImpl()

        wireframe.viewController = viewController

        let viewModel = SearchViewModel(
            extra: .init(
                wireframe: wireframe
            )
        )

        viewController.viewModel = viewModel

        return viewController
    }
}

