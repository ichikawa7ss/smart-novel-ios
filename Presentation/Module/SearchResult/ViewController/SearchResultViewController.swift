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

final class SearchResultViewController: UIViewController, ShowLoadingView {

    var loadingViewManager = LoadingViewManager()

    var viewModel: SearchResultViewModelType!

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
        self.setup()
    }
    
    private func setup() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "アプリに戻る", style: .plain, target: nil, action: nil)
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
        
        self.tableView.rx.reachedBottom()
            .skip(1) // 画面遷移直後、要素が無い状態の時にreachedBottomが来ちゃうので初回は無視する
            .bind(to: self.viewModel.input.reachedBottom)
            .disposed(by: self.disposeBag)
        
        self.rx.viewWillAppear
            .bind(onNext: { _ in
                let notification = NotificationTypes.SwitchButton.Display.hide
                NotificationCenter.default.post(name: notification.name, object: notification.object)
            })
            .disposed(by: self.disposeBag)

    }
}

// MARK: - bind output
extension SearchResultViewController {

    private func bindOutput() {
        
        self.viewModel.output.novels
            .bind { [weak self] _ in
                self?.tableView.reloadData()
            }
            .disposed(by: disposeBag)
        
        self.viewModel.output.networkState
            .bind(to: self.rx.networkState)
            .disposed(by: self.disposeBag)

    }
}

extension SearchResultViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.output.novels.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = self.viewModel.output.novels.value[safe: indexPath.row] else {
                return UITableViewCell()
        }
        let cell = self.novelListCell(tableView.dequeueReusableCell(for: indexPath), data: item)
        return cell
    }
    
    private func novelListCell(_ cell: NovelListCell, data: NovelListModel.Novel) -> NovelListCell {
        
        cell.setData(data)
        
        cell.cellDidTapRelay
            .bind(onNext: { [weak self] novel in
                self?.viewModel.input.tapNovelListCell(novel)
            })
            .disposed(by: cell.disposeBag)
        
        return cell
    }
}

extension SearchResultViewController: UITableViewDelegate {}

