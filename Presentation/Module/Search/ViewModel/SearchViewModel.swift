//
//  SearchSearchViewModel.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 14/10/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import Action
import RxCocoa
import RxSwift
import Unio
import Domain

protocol SearchViewModelType: AnyObject {
    var input: InputWrapper<SearchViewModel.Input> { get }
    var output: OutputWrapper<SearchViewModel.Output> { get }
}

final class SearchViewModel: UnioStream<SearchViewModel>, SearchViewModelType  {

    init(extra: Extra) {
        super.init(input: Input(),
                   state: State(),
                   extra: extra)
    }
}

extension SearchViewModel {

    struct Input: InputType {
        let viewWillAppear = PublishRelay<Void>()
        let didTapSearchNovel = PublishRelay<String>()
        let didTapCandidateTagCell = PublishRelay<NovelListModel.Novel.Tag>()
    }

    struct Output: OutputType {
        let tags: BehaviorRelay<[NovelListModel.Novel.Tag]>
    }
    
    struct State: StateType {
        let tags = BehaviorRelay<[NovelListModel.Novel.Tag]>(value: [])
    }

    struct Extra: ExtraType {
        let wireframe: SearchWireframe
        let useCase: SearchUseCase
    }
}

extension SearchViewModel {

    static func bind(from dependency: Dependency<Input, State, Extra>, disposeBag: DisposeBag) -> Output {
        let input = dependency.inputObservables
        let state = dependency.state
        let extra = dependency.extra
        
        input.viewWillAppear
            .flatMap { extra.useCase.getCandidateTags() }
            .bind(to: state.tags)
            .disposed(by: disposeBag)
        
        input.didTapSearchNovel
            .bind(onNext: { text in
                // TODO: 画面遷移
            })
            .disposed(by: disposeBag)
                
        input.didTapCandidateTagCell
            .bind(onNext: { tag in
                // TODO: 画面遷移
            })
            .disposed(by: disposeBag)
        
        return Output(
            tags: state.tags
        )
    }
}
