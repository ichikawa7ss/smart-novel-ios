//
//  NovelDetailWebNovelDetailWebViewController.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 03/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import UIKit
import RxWebKit
import WebKit

final class NovelDetailWebViewController: UIViewController {

    var viewModel: NovelDetailWebViewModelType!
    
    var requestURL: URL!
    
    var webView: WKWebView = WKWebView()
    
    private let safariButton = UIBarButtonItem(image: UIImage(systemName: "safari"), style: .plain, target: nil, action: nil)

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        view = webView
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindInput()
        self.bindOutput()
        self.setupNavigationBar()
        self.loadWebContent()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = self.safariButton
    }
    
    private func loadWebContent() {
        let urlRequest = URLRequest(url: requestURL)
        self.webView.load(urlRequest)
    }
}

// MARK: - bind input
extension NovelDetailWebViewController {

    private func bindInput() {
        
        self.safariButton.rx.tap
            .map { self.requestURL }
            .bind(to: self.viewModel.input.tapSafariButton)
            .disposed(by: self.disposeBag)
    }
}

// MARK: - bind output
extension NovelDetailWebViewController {

    private func bindOutput() {
    }
}
