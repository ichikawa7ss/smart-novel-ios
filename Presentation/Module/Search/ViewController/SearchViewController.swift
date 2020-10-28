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

final class SearchViewController: UIViewController, ShowActionSheetView {

    var viewModel: SearchViewModelType!

    @IBOutlet private weak var slideSearchHeaderView: SlideSearchHeaderView! {
        willSet {
            newValue.delegate = self
        }
    }
    

    @IBOutlet private weak var tableView: UITableView! {
        willSet {
            newValue.register(SortFilterCell.self)
            newValue.register(GenreGroupTableCell.self)
        }
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.bindInput()
        self.bindOutput()
    }
    
    private func setup() {
        
    }
}

// MARK: - bind input
extension SearchViewController {

    private func bindInput() {
        
        self.rx.viewWillAppear
            .map { _ in }
            .bind(onNext: { [weak self] _ in
                self?.navigationController?.setNavigationBarHidden(true, animated: true)
            })
            .disposed(by: self.disposeBag)
        
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

        self.viewModel.output.model
            .bind { [weak self] _ in
                self?.tableView.reloadData()
            }
            .disposed(by: self.disposeBag)

        self.viewModel.output.tapSortsView
            .bind(onNext: { [weak self] sortsField in
                // アクションシート表示
                self?.showActionSheet(title: nil, message: nil, items: sortsField, completion: { item in
                    self?.viewModel.input.accept(item, for: \.didSelectSortsField)
                })
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.didSelectSorts
            .skip(1) // tableViewがないときにきてしまうのでskip(1)
            .bind { [weak self] _ in
                self?.tableView.reloadRows(at: [IndexPath(item: 0, section: 0)], with: .automatic)
            }
            .disposed(by: self.disposeBag)
        
    }
}

extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 // ソートセルとジャンルセル
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let model = self.viewModel.output.model.value else {
            return UITableViewCell()
        }
        
        if indexPath.row == 0 {
            let cell = self.sortFilterCell(tableView.dequeueReusableCell(for: indexPath), sortField: self.viewModel.output.didSelectSorts.value)
            return cell
        }
        
        if indexPath.row == 1 {
            let cell = self.genreGroupCell(tableView.dequeueReusableCell(for: indexPath), data: model.genres)
            return cell
        }
        
        return UITableViewCell() // ここまではこないはず
    }

    private func sortFilterCell(_ cell: SortFilterCell, sortField: NovelListModel.Novel.SortField) -> SortFilterCell {
        cell.setData(text: sortField.text)
        
        cell.changeSortFiledDidTapRelay
            .bind(onNext: { [weak self] _ in
                self?.viewModel.input.didTapChangeSortFieldView(())
            })
            .disposed(by: self.disposeBag)
        
        return cell
    }

    private func genreGroupCell(_ cell: GenreGroupTableCell, data: [NovelListModel.Novel.SearchableGenre]) -> GenreGroupTableCell {
        cell.setData(data)
        
        cell.genreViewDidTapRelay
            .bind(to: self.viewModel.input.didTapSearchableGenreView)
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
