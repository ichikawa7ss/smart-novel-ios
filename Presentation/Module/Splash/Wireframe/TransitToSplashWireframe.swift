//
//  SplashTransitToSplashWireframe.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 28/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit

protocol TransitToSplashWireframe: AnyObject {

    var viewController: UIViewController? { get }

    // func pushSplash()
    // func presentSplash()
}

extension TransitToSplashWireframe {

    //func pushSplash() {
    //    let vc = SplashBuilder.build()
    //    self.viewController?.navigationController?.pushViewController(vc, animated: true)
    //}

    //func presentSplash() {
    //    let vc = SplashBuilder.build()
    //    self.viewController?.present(vc, animated: true, completion: nil)
    //}
}

//protocol SplashWireframeDelegate: AnyObject {}
