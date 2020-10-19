//
//  SearchResultSearchResultViewController.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 19/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit
import Domain
import RxCocoa
import RxSwift

final class SearchResultViewController: UIViewController {

    var viewModel: SearchResultViewModelType!

    @IBOutlet private weak var tableView: UITableView! {
        willSet {
            newValue.register(SortFilterCell.self)
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
extension SearchResultViewController {

    private func bindInput() {
        
        self.rx.viewWillAppear
            .take(1) // 初回のみ取得
            .map { _ in }
            .bind(to: self.viewModel.input.viewWillAppear)
            .disposed(by: disposeBag)
    }
}

// MARK: - bind output
extension SearchResultViewController {

    private func bindOutput() {
    }
}

extension SearchResultViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
