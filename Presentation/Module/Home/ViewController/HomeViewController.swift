//
//  HomeHomeViewController.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 24/08/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit
import Domain
import RxCocoa
import RxSwift

final class HomeViewController: UIViewController {

    var viewModel: HomeViewModelType!
    
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
        self.setNavigationTitleView(UIImage(named: "app_header")!)
    }
    
    /// Naviagationのタイトルを画像でSETする
    private func setNavigationTitleView(_ image: UIImage) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)) // 画像サイズから表示Viewのサイズを決める
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
    }
}

// MARK: - bind input
extension HomeViewController {

    private func bindInput() {
        
        // 画面表示
        self.rx.viewWillAppear
            .take(1) // 初回のみ取得
            .map { _ in }
            .bind(to: self.viewModel.input.viewWillAppear)
            .disposed(by: self.disposeBag)
        
        self.tableView.rx.reachedBottom()
            .skip(1) // 画面遷移直後、要素が無い状態の時にreachedBottomが来ちゃうので初回は無視する
            .bind(to: self.viewModel.input.reachedBottom)
            .disposed(by: self.disposeBag)
    }
}
    
// MARK: - bind output
extension HomeViewController {

    private func bindOutput() {
        
        self.viewModel.output.novels
            .bind { [weak self] _ in
                self?.tableView.reloadData()
            }
            .disposed(by: disposeBag)
        
    }
}

extension HomeViewController: UITableViewDataSource {

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

extension HomeViewController: UITableViewDelegate {}
