//
//  NovelListNovelListViewModel.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 24/08/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import Action
import RxCocoa
import RxSwift
import Unio

protocol NovelListViewModelType: AnyObject {
    var input: InputWrapper<NovelListViewModel.Input> { get }
    var output: OutputWrapper<NovelListViewModel.Output> { get }
}

final class NovelListViewModel: UnioStream<NovelListViewModel>, NovelListViewModelType  {

    init(extra: Extra) {
        super.init(input: Input(),
                   state: State(),
                   extra: extra)
    }
}

extension NovelListViewModel {

    struct Input: InputType {
        // e.g.
        // let viewWillAppear = PublishRelay<Void>()
    }

    struct Output: OutputType {
        // e.g.
        // let reloadAll: Observable<Void>
        // let sections: BehaviorRelay<[NovelListViewController.Section]>
    }
    
    struct State: StateType {
        // e.g.
        // let networkState = PublishRelay<NetworkState>()
    }

    struct Extra: ExtraType {
        let wireframe: NovelListWireframe
    }
}

extension NovelListViewModel {

    static func bind(from dependency: Dependency<Input, State, Extra>, disposeBag: DisposeBag) -> Output {
        let input = dependency.inputObservables
        let state = dependency.state
        var extra = dependency.extra
        
        return Output(
        )
    }
}
