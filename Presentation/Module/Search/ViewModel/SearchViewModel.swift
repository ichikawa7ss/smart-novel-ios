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
         let didTapSearchNovel = PublishRelay<String>()
    }

    struct Output: OutputType {
        let novels: BehaviorRelay<[NovelListModel.Novel]>
    }
    
    struct State: StateType {
        let novels = BehaviorRelay<[NovelListModel.Novel]>(value: [])
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
        
        let fetchData = Action<String, NovelListModel> { text in
            extra.useCase.get(text: text)
        }
        
        input.didTapSearchNovel
            .bind(onNext: { text in
                fetchData.execute(text)
            })
            .disposed(by: disposeBag)
        
        fetchData.elements
            .flatMap { model -> BehaviorRelay<[NovelListModel.Novel]> in
                var retNovels = state.novels.value
                retNovels += model.novels
                return BehaviorRelay(value: retNovels)
            }
            .bind(to: state.novels)
            .disposed(by: disposeBag)
        
        return Output(
            novels: state.novels
        )
    }
}
