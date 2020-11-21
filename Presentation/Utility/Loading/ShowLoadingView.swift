//
//  ShowLoadingView.swift
//  Presentation
//
//  Created by ichikawa on 2020/11/07.
//

import Action
import RxCocoa
import RxSwift
import UIKit

protocol ShowLoadingView: class {

    func showLoadingView()
    func hideLoadingView()
    func updateNetworkState(_ networkState: NetworkState)
    
    var loadingViewManager: LoadingViewManager { get }
}

extension ShowLoadingView where Self: UIViewController {

    func showLoadingView() {
        self.loadingViewManager.show(on: self.view)
    }

    func hideLoadingView() {
        self.loadingViewManager.hide()
    }
}

extension Reactive where Base: UIViewController & ShowLoadingView {
    
    var networkState: Binder<NetworkState> {
        return .init(base) { vc, state in
            vc.updateNetworkState(state)
        }
    }
}

extension ShowLoadingView where Self: UIViewController {
    
    func updateNetworkState(_ networkState: NetworkState) {
        switch networkState {
        case .error:
            self.hideLoadingView()
        case .loading:
            self.showLoadingView()
        case .normal:
            self.hideLoadingView()
        }
    }
}
