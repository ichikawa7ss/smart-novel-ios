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
import Domain

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
        let viewWillAppear = PublishRelay<Void>()
        let didTapChangeSortFieldView  = PublishRelay<Void>()
        let didSelectSortsField = PublishRelay<NovelListModel.Novel.SortField>()
    }

    struct Output: OutputType {
        let tapSortsView: PublishRelay<[NovelListModel.Novel.SortField]>
    }
    
    struct State: StateType {
        let tapSortsView = PublishRelay<[NovelListModel.Novel.SortField]>()
        let selectSorts = PublishRelay<NovelListModel.Novel.SortField>()
    }

    struct Extra: ExtraType {
        let wireframe: SearchResultWireframe
        let useCase: SearchResultUseCase
    }
}

extension SearchResultViewModel {

    static func bind(from dependency: Dependency<Input, State, Extra>, disposeBag: DisposeBag) -> Output {
        let input = dependency.inputObservables
        let state = dependency.state
        let extra = dependency.extra
        
        let fetchDataWithWord = Action<(text: String, order: NovelListModel.Novel.SortField), NovelListModel> { args in
            extra.useCase.get(text: args.text, order: args.order)
        }
        
        let fetchSpecificGenre = Action<(genre: String, order: NovelListModel.Novel.SortField), NovelListModel> { args in
            extra.useCase.get(genre: args.genre, order: args.order)
        }
        
        input.viewWillAppear
            .bind(onNext: { _ in
                // fetchAction
            })
            .disposed(by: disposeBag)
        
        input.didTapChangeSortFieldView
            .flatMap { extra.useCase.getSortField() }
            .bind(to: state.tapSortsView)
            .disposed(by: disposeBag)
        
        input.didSelectSortsField
            .bind(onNext: { _ in
                // fetchAction
            })
            .disposed(by: disposeBag)
        
        return Output(
            tapSortsView: state.tapSortsView
        )
    }
}
