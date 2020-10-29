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
    
    var selectedDestinationButtonTypeRelay = BehaviorRelay<ContentType.DestinationButtonType>(value: .toSearch)
    
    func setup() {
        self.bind()
        toHomeButtonView.transform = CGAffineTransform(rotationAngle: .pi) // 画像を反転させておく
    }
    
    private func bind() {
        Observable.merge(
            self.toSearchButtonViewTapped,
            self.toHomeButtonViewTapped
        )
            .bind(onNext: { [weak self] buttonType in
                self?.selectedDestinationButtonTypeRelay.accept(buttonType)
                self?.rx.rotate.onNext(buttonType)
            })
            .disposed(by: self.disposeBag)
    }
}

extension SwitchButtonView {
    
    private var toSearchButtonViewTapped: Observable<ContentType.DestinationButtonType> {
        return self.toSearchButtonView.didTouchUpInsideObservable.map { _ in .toSearch }
    }
    
    private var toHomeButtonViewTapped: Observable<ContentType.DestinationButtonType> {
        return self.toHomeButtonView.didTouchUpInsideObservable.map { _ in .toHome }
    }
}

extension Reactive where Base: SwitchButtonView {
    
    var rotate: Binder<ContentType.DestinationButtonType> {
        return Binder(base) { view, type in
            UIView.animate(withDuration: 0.3) {
                switch type {
                case .toSearch:
                    // 検索画面への遷移だったら時計回りで回転
                    view.transform = CGAffineTransform(rotationAngle: -.pi * 0.999) // 反転時は時計回りにしたいので半回転しきらないようにしておく
                case .toHome:
                    // ホーム画面への遷移だったら反時計回りで戻す
                    view.transform = .identity
                }
            }
        }
    }
    
    var show: Binder<Bool> {
        return Binder(base) { view, show in
            let alpha: CGFloat = show ? 1.0 : 0.0
            if view.isHidden { view.isHidden = false }
            UIView.animate(withDuration: 0.1,
                           animations: {
                            view.alpha = alpha
            },
                           completion: { _ in
                            view.isHidden = !show
            })
        }
    }
}
