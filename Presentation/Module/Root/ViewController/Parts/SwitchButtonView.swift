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
        toHomeButtonView.transform = CGAffineTransform(rotationAngle: .pi) // 画像を反転させておく
    }
    
    private func bind() {
        Observable.merge(
            self.toSearchButtonViewTapped,
            self.toHomeButtonViewTapped
        )
            .bind(onNext: { [weak self] selectedIndex in
                self?.selectedTabRelay.accept(selectedIndex)
                self?.rx.rotate.onNext(selectedIndex)
            })
            .disposed(by: self.disposeBag)
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

extension Reactive where Base: SwitchButtonView {
    
    var rotate: Binder<TabIndex> {
        return Binder(base) { view, selectedIndex in
            UIView.animate(withDuration: 0.5) {
                switch selectedIndex {
                case .toSearch:
                    // デフォルトだったら時計回りで回転
                    view.transform = CGAffineTransform(rotationAngle: .pi * 0.999) // 反転時は時計回りにしたいので半回転しきらないようにしておく
                case .toHome:
                    // 既に反転してたらもとに反時計回りで戻す
                    view.transform = .identity
                }
            }
        }
    }
}
