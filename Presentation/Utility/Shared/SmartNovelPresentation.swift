//
//  SmartNovelPresentation.swift
//  Presentation
//
//  Created by ichikawa on 2020/10/28.
//

import UIKit

/// シングルトンで保持しておきたい定義のうちPresentation層で扱うべきもの
public class SmartNovelPresentation {

    public static let shared = SmartNovelPresentation()

    /// AppDelegate or SceneDelegateのUIWindow
    public private(set) weak var applicationWindow: UIWindow!
    
    private init() {}
}

extension SmartNovelPresentation {

    public func setWindow(_ window: UIWindow?) {
        self.applicationWindow = window
    }
}
