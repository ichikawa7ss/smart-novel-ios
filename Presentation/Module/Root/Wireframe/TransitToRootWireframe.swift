//
//  RootTransitToRootWireframe.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 21/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit

protocol TransitToRootWireframe: AnyObject {

    var viewController: UIViewController? { get }

     func showRoot()
}

extension TransitToRootWireframe {

    func showRoot() {
        let rootViewController = RootBuilder.build()
        if let window = SmartNovelPresentation.shared.applicationWindow {
            UIView.transition(
                with: window,
                duration: 0.5,
                options: .transitionCrossDissolve,
                animations: {
                    let prevState = UIView.areAnimationsEnabled
                    UIView.setAnimationsEnabled(false)
                    window.rootViewController = rootViewController
                    UIView.setAnimationsEnabled(prevState)
                }
            )
        }
    }
}
