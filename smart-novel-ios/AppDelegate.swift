//
//  AppDelegate.swift
//  smart-novel-ios
//
//  Created by ichikawa on 2020/08/19.
//

import UIKit
import Presentation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = SplashBuilder.build()
        self.window?.makeKeyAndVisible()
        SmartNovelPresentation.shared.setWindow(window)

        return true
    }
}

