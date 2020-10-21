//
//  RootRootViewController.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 21/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {

    var viewModel: RootViewModelType!
    var vcList: [UIViewController] = []

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var switchButtonView: UIView!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.bindInput()
        self.bindOutput()
    }
}
// MARK: - setup
extension RootViewController {

    private func setup() {
        self.setInnerViewController(tabIndex: 0)
        // ボタン側のセットアップ
//        self.bottomTabView.setup()
    }
    
    private func setInnerViewController(tabIndex: Int) {
        let vc = self.vcList[tabIndex]
        let navVC = UINavigationController(rootViewController: vc)
        self.addChild(navVC)
        let currentView = self.containerView.subviews.first ?? UIView()
        UIView.transition(
            from: currentView,
            to: navVC.view,
            duration: 0.2,
            options: .transitionCrossDissolve,
            completion: { [weak self] _ in
                guard let `self` = self else { return }
                navVC.didMove(toParent: self) // TODO: 確認
                if let view = self.containerView.subviews.first {
                    view.matchParent(self.containerView)
                }
        })

    }
}
// MARK: - bind input
extension RootViewController {

    private func bindInput() {

        // タブタップ
//        self.bottomTabView.selectedTabRelay
//            .throttle(0.5, scheduler: MainScheduler.instance)
//            .bind(onNext: { [weak self] selectedTab in
//                self?.setInnerViewController(tabIndex: selectedTab)
//            })
//            .disposed(by: self.disposeBag)
    }
}

// MARK: - bind output
extension RootViewController {

    private func bindOutput() {
    }
}
