//
//  SearchResultSearchResultBuilder.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 19/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit

enum SearchResultBuilder {

    static func build() -> UIViewController {
        let viewController = SearchResultViewController.instantiate()
        let wireframe = SearchResultWireframeImpl()

        wireframe.viewController = viewController

        let viewModel = SearchResultViewModel(
            extra: .init(
                wireframe: wireframe
            )
        )

        viewController.viewModel = viewModel

        return viewController
    }
}

