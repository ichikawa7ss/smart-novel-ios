//
//  SplashSplashViewController.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 28/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SplashViewController: UIViewController, ShowErrorAlertView {
    
    var viewModel: SplashViewModelType!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindInput()
        self.bindOutput()
    }
}

// MARK: - bind input
extension SplashViewController {

    private func bindInput() {
        
        // 画面表示
        self.rx.viewWillAppear
            .take(1) // 初回のみ取得
            .map { _ in }
            .bind(to: self.viewModel.input.fetchFacetsTrigger)
            .disposed(by: self.disposeBag)
        
        
    }
}

// MARK: - bind output
extension SplashViewController {

    private func bindOutput() {
        
        self.viewModel.output.error
            .bind(onNext: { error in
                self.showErrorAlert(error, closeHandler: {})
            }).disposed(by: self.disposeBag)
    }
}
