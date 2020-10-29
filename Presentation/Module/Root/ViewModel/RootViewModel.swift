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
import Domain

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
         let needsShowSwitchButton: BehaviorRelay<Bool>
    }
    
    struct State: StateType {
         let needsShowSwitchButton = BehaviorRelay<Bool>(value: true)
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

        NotificationTypes.SwitchButton.Display.allCases.forEach {
            NotificationCenter.default.rx.notification($0.name, object: $0.object)
                .map { ($0.object as? Bool ?? true) }
                .bind(to: state.needsShowSwitchButton)
                .disposed(by: disposeBag)
        }
        
        return Output(
            needsShowSwitchButton: state.needsShowSwitchButton
        )
    }
}
