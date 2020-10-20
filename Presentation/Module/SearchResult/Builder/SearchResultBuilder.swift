//
//  SearchResultSearchResultBuilder.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 19/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit
import Domain

enum SearchResultBuilder {

    static func build(searchCondition: SearchTransitType) -> UIViewController {
        let viewController = SearchResultViewController.instantiate()
        let wireframe = SearchResultWireframeImpl()

        wireframe.viewController = viewController

        let viewModel = SearchResultViewModel(
            extra: .init(
                wireframe: wireframe,
                useCase: SearchResultUseCaseProvider.provide(),
                searchCondition: searchCondition
            )
        )

        viewController.viewModel = viewModel

        return viewController
    }
}

