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
import Domain

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
        self.navigationController?.navigationBar.isTranslucent = false // ナビが-ションバーを半透明にする
        self.edgesForExtendedLayout = .bottom // viewの拡張をNavigationBarのボトムまでに設定
        self.navigationItem.rightBarButtonItem = self.safariButton // safariボタン
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
        
        self.rx.viewWillAppear
            .bind(onNext: { _ in
                let notification = NotificationTypes.SwitchButton.Display.hide
                NotificationCenter.default.post(name: notification.name, object: notification.object)
            })
            .disposed(by: self.disposeBag)
    }
}

// MARK: - bind output
extension NovelDetailWebViewController {

    private func bindOutput() {
    }
}
