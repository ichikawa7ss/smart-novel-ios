//
//  ShowErrorAlertView.swift
//  Presentation
//
//  Created by ichikawa on 2020/11/21.
//

import UIKit
import APIKit
import Action

typealias AlertHandler = () -> Void

protocol ShowErrorAlertView {

    /// 閉じるボタン(処理あり)のみのエラーアラート
    /// - Parameters:
    ///   - error: エラー
    ///   - closeHandler: 閉じる処理
    func showErrorAlert(_ error: Error, closeHandler: @escaping AlertHandler)
    
    /// リトライボタン＋閉じるボタンエラーアラート
    /// - Parameters:
    ///   - error: エラー
    ///   - retryHandler: リトライ処理
    ///   - closeHandler: 閉じる処理
    func showErrorAlert(_ error: Error, retryHandler: AlertHandler?, closeHandler: AlertHandler?)
    
}

extension ShowErrorAlertView where Self: UIViewController {

    func showErrorAlert(_ error: Error, closeHandler: @escaping AlertHandler) {
        self.showErrorAlert(error, retryHandler: nil, closeHandler: closeHandler)
    }
    
    func showErrorAlert(_ error: Error, retryHandler: AlertHandler?, closeHandler: AlertHandler?) {
        let actions = self.alertActions(error, retryHandler: retryHandler, closeHandler: closeHandler)
        self.showErrorAlert(error: error, actions: actions)
    }

    private func alertActions(_ error: Error, retryHandler: AlertHandler?, closeHandler: AlertHandler?) -> [UIAlertAction] {
        var alertActions = [UIAlertAction]()
        
        if let handler = retryHandler {
            alertActions.append(UIAlertAction.retry(handler))
        }

        if let handler = closeHandler {
            alertActions.append(UIAlertAction.close(handler))
        }
        
        return alertActions
    }

    /// エラーダイアログ
    private func showErrorAlert(error: Error, actions: [UIAlertAction]) {
        if let urlError = error.rootError as? URLError {
            self.showConnectionFailedAlert(error: urlError, actions: actions)
            return
        }

        self.showUnknownErrorAlert(error, actions: actions)
    }

    /// 通信失敗時のアラート表示
    private func showConnectionFailedAlert(error: Error, actions: [UIAlertAction]) {
        self.showAlert(title: "通信に失敗しました", message: "電波状況をご確認ください", actions: actions)
    }

    private func showUnknownErrorAlert(_ error: Error, actions: [UIAlertAction]) {
        self.showAlert(title: "不明なエラー", message: "時間をおいてお試しください", actions: actions)
    }

    private func showAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }

        // メインスレッド以外からエラーが流れてきた場合も、メインスレッドでアラートを表示する
        if Thread.isMainThread {
            self.present(alert, animated: true, completion: nil)
        }
        else {
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

// MARK: - UIAlertAction
private extension UIAlertAction {

    /// 閉じるボタン
    static func close(_ handler: AlertHandler? = nil) -> UIAlertAction {
        return UIAlertAction(title: "閉じる", style: .default) { _ in handler?() }
    }
    
    /// リトライボタン
    static func retry(_ handler: @escaping AlertHandler) -> UIAlertAction {
        return UIAlertAction(title: "リトライ", style: .default) { _ in handler() }
    }
}

extension Error {

    /// 再起的にルートエラーを取り出す
    var rootError: Error {
        if let error = self as? SessionTaskError {
            switch error {
            case .connectionError(let error),
                 .requestError(let error),
                 .responseError(let error):
                return error.rootError
            @unknown default:
                fatalError("エラーが増えたときはケースを追加する")
            }
        }
        if let error = self as? ActionError {
            switch error {
            case .notEnabled:
                return self
            case .underlyingError(let cause):
                return cause.rootError
            }
        }
        return self
    }
}
