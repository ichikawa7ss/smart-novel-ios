//
//  SearchSearchViewController.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 14/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit
import Domain
import RxCocoa
import RxSwift

final class SearchViewController: UIViewController {

    var viewModel: SearchViewModelType!

    @IBOutlet private weak var slideSearchHeaderView: SlideSearchHeaderView! {
        willSet {
            newValue.delegate = self
        }
    }
    

    @IBOutlet private weak var tableView: UITableView! {
        willSet {
            newValue.register(SearchCandidateTagHeaderCell.self)
            newValue.register(SearchCandidateTagCell.self)
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
extension SearchViewController {

    private func bindInput() {
        
        self.rx.viewWillAppear
            .take(1) // 初回のみ
            .map { _ in }
            .bind(to: self.viewModel.input.viewWillAppear)
            .disposed(by: self.disposeBag)
    }
}

// MARK: - bind output
extension SearchViewController {

    private func bindOutput() {

        self.viewModel.output.tags
            .bind { [weak self] _ in
                self?.tableView.reloadData()
            }
            .disposed(by: disposeBag)

    }
}

extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.output.tags.value.count + 1 // ヘッダーセル分+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            let cell = self.searchCandidateTagHeaderCell(tableView.dequeueReusableCell(for: indexPath))
            return cell
        }
        
        guard let item = self.viewModel.output.tags.value[safe: indexPath.row - 1] else {
                return UITableViewCell()
        }
        let cell = self.searchCandidateTagCell(tableView.dequeueReusableCell(for: indexPath), data: item)
        return cell
    }

    private func searchCandidateTagHeaderCell(_ cell: SearchCandidateTagHeaderCell) -> SearchCandidateTagHeaderCell {
        return cell
    }

    private func searchCandidateTagCell(_ cell: SearchCandidateTagCell, data: NovelListModel.Novel.Tag) -> SearchCandidateTagCell {

        cell.setData(data)
        
        cell.cellDidTapRelay
            .bind(onNext: { [weak self] tag in
                self?.viewModel.input.didTapCandidateTagCell(tag)
            })
            .disposed(by: cell.disposeBag)
        
        return cell
    }
}

extension SearchViewController: SlideSearchHeaderViewDelegate {
    
    func willStartExpandAnimation(_ searchHeaderView: SlideSearchHeaderView) {
        print("willStartExpandAnimation")
    }
    
    func willStartShrinkAnimation(_ searchHeaderView: SlideSearchHeaderView) {
        print("willStartShrinkAnimation")
    }
    
    func slideSearchHeaderView(_ searchHeaderView: SlideSearchHeaderView, didEnterTextField: UITextField) {
        self.viewModel.input.accept(didEnterTextField.text ?? "", for: \.didTapSearchNovel)
        print("didEnterTextField")
    }
    
    func slideSearchHeaderView(_ searchHeaderView: SlideSearchHeaderView, didChangeCharacters: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) {
        print("didChangeCharacters")
    }
}
