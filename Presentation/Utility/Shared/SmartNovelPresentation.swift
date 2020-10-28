//
//  SmartNovelPresentation.swift
//  Presentation
//
//  Created by ichikawa on 2020/10/28.
//

import UIKit

// めちゃコミ固有のシングルトンで保持しておきたい環境周りの定義
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
