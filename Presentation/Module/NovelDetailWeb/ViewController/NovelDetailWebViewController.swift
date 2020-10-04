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
        self.loadWebContent()
    }
    
    private func loadWebContent() {
        let urlRequest = URLRequest(url: requestURL)
        self.webView.load(urlRequest)
    }
}

// MARK: - bind input
extension NovelDetailWebViewController {

    private func bindInput() {
    }
}

// MARK: - bind output
extension NovelDetailWebViewController {

    private func bindOutput() {
    }
}
