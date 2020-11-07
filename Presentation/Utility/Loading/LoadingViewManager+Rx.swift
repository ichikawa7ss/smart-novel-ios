//
//  LoadingViewManager+Rx.swift
//  Presentation
//
//  Created by ichikawa on 2020/11/07.
//

import RxSwift
import RxCocoa

extension Reactive where Base : ShowLoadingView {

    /// Bindable sink for loading view.
    var loading: Binder<Bool> {
        return Binder(self.base) { base, loading in
            loading ? base.showLoadingView() : base.hideLoadingView()
        }
    }
}
