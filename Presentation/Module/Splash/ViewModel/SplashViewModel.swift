//
//  SplashSplashViewModel.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 28/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import Action
import RxCocoa
import RxSwift
import Unio
import Domain

protocol SplashViewModelType: AnyObject {
    var input: InputWrapper<SplashViewModel.Input> { get }
    var output: OutputWrapper<SplashViewModel.Output> { get }
}

final class SplashViewModel: UnioStream<SplashViewModel>, SplashViewModelType  {

    init(extra: Extra) {
        super.init(input: Input(),
                   state: State(),
                   extra: extra)
    }
}

extension SplashViewModel {

    struct Input: InputType {
         let fetchFacetsTrigger = PublishRelay<Void>()
    }

    struct Output: OutputType {
        let error: Observable<Error>
    }
    
    struct State: StateType {
    }

    struct Extra: ExtraType {
        let wireframe: SplashWireframe
        let useCase: SplashUseCase
    }
}

extension SplashViewModel {

    static func bind(from dependency: Dependency<Input, State, Extra>, disposeBag: DisposeBag) -> Output {
        let input = dependency.inputObservables
        let extra = dependency.extra
        
        let fetchFacetsAction = Action<Void, FacetsModel> { _ in
            extra.useCase.get()
        }
        
        
        input.fetchFacetsTrigger
            .bind(onNext: { _ in
                fetchFacetsAction.execute()
            })
            .disposed(by: disposeBag)
        
        fetchFacetsAction.elements
            .bind(onNext: { model in
                extra.useCase.setSearchableTags(model)
                extra.wireframe.showRoot()
            })
            .disposed(by: disposeBag)
        
        return Output(
            error: fetchFacetsAction.underlyingError
        )
    }
}
