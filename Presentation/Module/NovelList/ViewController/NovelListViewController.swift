//
//  NovelListNovelListViewController.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 24/08/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit
import Domain

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
        
        self.viewModel.output.novelListModel
            .bind { [weak self] _ in
                self?.tableView.reloadData()
        }
        .disposed(by: disposeBag)
        
    }
}

extension NovelListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.output.novelListModel.value?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let items = self.viewModel.output.novelListModel.value?.items,
            let item = items[safe: indexPath.row] else {
                return UITableViewCell()
        }
        let cell: NovelListCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setData(item)
        return cell
    }
}
