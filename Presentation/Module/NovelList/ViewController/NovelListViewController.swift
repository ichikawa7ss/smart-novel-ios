//
//  NovelListNovelListViewController.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 24/08/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit

final class NovelListViewController: UIViewController {

    var viewModel: NovelListViewModelType!
    
    @IBOutlet private weak var tableView: UITableView! {
        willSet {
            newValue.register(NovelListCell.self)
        }
    }

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindInput()
        self.bindOutput()
    }
}

// MARK: - bind input
extension NovelListViewController {

    private func bindInput() {
        
        // 画面表示
        self.rx.viewWillAppear
            .map { _ in }
            .bind(to: self.viewModel.input.viewWillAppear)
            .disposed(by: self.disposeBag)
    }
}

// MARK: - bind output
extension NovelListViewController {

    private func bindOutput() {
    }
}
