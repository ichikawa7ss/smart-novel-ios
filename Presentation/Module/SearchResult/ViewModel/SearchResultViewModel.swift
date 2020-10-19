//
//  SearchResultSearchResultViewModel.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 19/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import Action
import RxCocoa
import RxSwift
import Unio

protocol SearchResultViewModelType: AnyObject {
    var input: InputWrapper<SearchResultViewModel.Input> { get }
    var output: OutputWrapper<SearchResultViewModel.Output> { get }
}

final class SearchResultViewModel: UnioStream<SearchResultViewModel>, SearchResultViewModelType  {

    init(extra: Extra) {
        super.init(input: Input(),
                   state: State(),
                   extra: extra)
    }
}

extension SearchResultViewModel {

    struct Input: InputType {
        // e.g.
        // let viewWillAppear = PublishRelay<Void>()
    }

    struct Output: OutputType {
        // e.g.
        // let reloadAll: Observable<Void>
        // let sections: BehaviorRelay<[SearchResultViewController.Section]>
    }
    
    struct State: StateType {
        // e.g.
        // let networkState = PublishRelay<NetworkState>()
    }

    struct Extra: ExtraType {
        let wireframe: SearchResultWireframe
    }
}

extension SearchResultViewModel {

    static func bind(from dependency: Dependency<Input, State, Extra>, disposeBag: DisposeBag) -> Output {
        let input = dependency.inputObservables
        let state = dependency.state
        var extra = dependency.extra
        
        return Output(
        )
    }
}
