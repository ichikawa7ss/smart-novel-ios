//
//  NovelDetailWebNovelDetailWebViewModel.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 03/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import Action
import RxCocoa
import RxSwift
import Unio

protocol NovelDetailWebViewModelType: AnyObject {
    var input: InputWrapper<NovelDetailWebViewModel.Input> { get }
    var output: OutputWrapper<NovelDetailWebViewModel.Output> { get }
}

final class NovelDetailWebViewModel: UnioStream<NovelDetailWebViewModel>, NovelDetailWebViewModelType  {

    init(extra: Extra) {
        super.init(input: Input(),
                   state: State(),
                   extra: extra)
    }
}

extension NovelDetailWebViewModel {

    struct Input: InputType {
         let tapSafariButton = PublishRelay<URL>()
    }

    struct Output: OutputType {
        // e.g.
        // let reloadAll: Observable<Void>
        // let sections: BehaviorRelay<[NovelDetailWebViewController.Section]>
    }
    
    struct State: StateType {
        // e.g.
        // let networkState = PublishRelay<NetworkState>()
    }

    struct Extra: ExtraType {
        let wireframe: NovelDetailWebWireframe
    }
}

extension NovelDetailWebViewModel {

    static func bind(from dependency: Dependency<Input, State, Extra>, disposeBag: DisposeBag) -> Output {
        let input = dependency.inputObservables
        let state = dependency.state
        let extra = dependency.extra
        
        input.tapSafariButton
            .bind(onNext: { url in
                extra.wireframe.transit(by: url)
            })
            .disposed(by: disposeBag)
        
        return Output(
        )
    }
}
