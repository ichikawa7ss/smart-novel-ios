//
//  SearchSearchViewController.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 14/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {

    var viewModel: SearchViewModelType!

    @IBOutlet private weak var slideSearchHeaderView: SlideSearchHeaderView! {
        willSet {
            newValue.delegate = self
        }
    }
    

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
extension SearchViewController {

    private func bindInput() {
    }
}

// MARK: - bind output
extension SearchViewController {

    private func bindOutput() {
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
        print("didEnterTextField")
    }
    
    func slideSearchHeaderView(_ searchHeaderView: SlideSearchHeaderView, didChangeCharacters: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) {
        print("didChangeCharacters")
    }
}
