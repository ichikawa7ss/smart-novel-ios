//
//  RootRootViewController.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 21/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit
import RxSwift

final class RootViewController: UIViewController {

    var viewModel: RootViewModelType!
    var vcList: [UIViewController] = []

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var contentView: UIView! // vcListの表示先としてcontentViewが必要
    @IBOutlet private weak var switchButtonView: SwitchButtonView!

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
        // 初期表示するVCのセットアップ
        self.setContentViewController(contentType: .home)
        // 初期表示するボタンのセットアップ
        self.switchButtonView.setup()
    }
    
    /// 指定されたコンテンツのVCにアニメーション遷移する
    /// - Parameter contentType: 表示するコンテンツ home/search
    private func setContentViewController(contentType: ContentType) {
        let vc = self.vcList[contentType.rawValue]
        let navVC = SmartNovelNavigationController(rootViewController: vc)
        self.addChild(navVC)
        let currentView = self.containerView.subviews.first ?? UIView()
        UIView.transition(
            from: currentView,
            to: navVC.view,
            duration: 0.3,
            options: .transitionCrossDissolve,
            completion: { [weak self] _ in
                guard let `self` = self else { return }
                // addChildをしたあとはトランジションが完了したらdidMoveを呼ばなきゃいけない
                // 呼んでいない場合、追加したViewControllerのviewWillAppear:が動作しない場合がある
                navVC.didMove(toParent: self)
                if let view = self.containerView.subviews.first {
                    view.matchParent(self.containerView)
                }
        })

    }
}
// MARK: - bind input
extension RootViewController {

    private func bindInput() {

        // コンテンツ切り替えボタンをタップ
        self.switchButtonView.selectedDestinationButtonTypeRelay
            .skip(1) // FIXME: 初回はBehaviorRelayの関係でスキップ1してるけど、スキップしなくてもいいようにしたい
            .bind(onNext: { [weak self] buttonType in
                self?.setContentViewController(contentType: buttonType.toContentType)
            })
            .disposed(by: self.disposeBag)
    }
}

// MARK: - bind output
extension RootViewController {

    private func bindOutput() {
    }
}
