//
//  SwitchButtonView.swift
//  Presentation
//
//  Created by ichikawa on 2020/10/21.
//

import UIKit
import RxSwift
import RxCocoa

final class SwitchButtonView: BaseView {
    
    @IBOutlet private weak var toHomeButtonView: HoverView!
    @IBOutlet private weak var toSearchButtonView: HoverView!
    
    var selectedTabRelay = BehaviorRelay<TabIndex>(value: .toSearch)
    
    func setup() {
        self.bind()
    }
    
    private func bind() {
        Observable.merge(
            self.toSearchButtonViewTapped,
            self.toHomeButtonViewTapped
        )
            .bind(onNext: { [weak self] selectedIndex in
                self?.selectedTabRelay.accept(selectedIndex)
                self?.rotateButtonView()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func rotateButtonView() {
        // TODO: Impl
    }
}

extension SwitchButtonView {
    
    private var toSearchButtonViewTapped: Observable<TabIndex> {
        return self.toSearchButtonView.didTouchUpInsideObservable.map { _ in TabIndex.toSearch }
    }
    
    private var toHomeButtonViewTapped: Observable<TabIndex> {
        return self.toHomeButtonView.didTouchUpInsideObservable.map { _ in TabIndex.toHome }
    }
}

enum TabIndex: Int {
    case toSearch
    case toHome
    
    var index: Int {
        return self.rawValue
    }
}
