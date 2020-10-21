//
//  RootRootViewModel.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 21/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import Action
import RxCocoa
import RxSwift
import Unio

protocol RootViewModelType: AnyObject {
    var input: InputWrapper<RootViewModel.Input> { get }
    var output: OutputWrapper<RootViewModel.Output> { get }
}

final class RootViewModel: UnioStream<RootViewModel>, RootViewModelType  {

    init(extra: Extra) {
        super.init(input: Input(),
                   state: State(),
                   extra: extra)
    }
}

extension RootViewModel {

    struct Input: InputType {
        // e.g.
        // let viewWillAppear = PublishRelay<Void>()
    }

    struct Output: OutputType {
        // e.g.
        // let reloadAll: Observable<Void>
        // let sections: BehaviorRelay<[RootViewController.Section]>
    }
    
    struct State: StateType {
        // e.g.
        // let networkState = PublishRelay<NetworkState>()
    }

    struct Extra: ExtraType {
        let wireframe: RootWireframe
    }
}

extension RootViewModel {

    static func bind(from dependency: Dependency<Input, State, Extra>, disposeBag: DisposeBag) -> Output {
        let input = dependency.inputObservables
        let state = dependency.state
        var extra = dependency.extra
        
        return Output(
        )
    }
}
