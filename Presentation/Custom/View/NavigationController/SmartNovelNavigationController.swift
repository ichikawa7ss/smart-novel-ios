//
//  SmartNovelNavigationController.swift
//  Presentation
//
//  Created by ichikawa on 2020/09/01.
//

import UIKit

public final class SmartNovelNavigationController: UINavigationController {

    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.setup()
    }

    public override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
        self.setup()
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
}

// MARK: - Setup
extension SmartNovelNavigationController {

    private func setup() {
        self.interactivePopGestureRecognizer?.delegate = nil
        self.setupAppearance()
    }

    private func setupAppearance() {
        // バーの背景色
        self.navigationBar.barTintColor = .orange
    }
}
