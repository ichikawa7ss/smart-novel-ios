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
        let didTapSearchableGenreView = PublishRelay<NovelListModel.Novel.SearchableGenre>()
        let didTapTagListView = PublishRelay<NovelListModel.Novel.Tag>()
        let didTapChangeSortFieldView  = PublishRelay<Void>()
        let didSelectSortsField = PublishRelay<NovelListModel.Novel.SortField>()
    }

    struct Output: OutputType {
        let model: BehaviorRelay<SearchModel?>
        let tapSortsView: PublishRelay<[NovelListModel.Novel.SortField]>
        let didSelectSorts: BehaviorRelay<NovelListModel.Novel.SortField>
    }
    
    struct State: StateType {
        let model = BehaviorRelay<SearchModel?>(value: nil)
        let tapSortsView = PublishRelay<[NovelListModel.Novel.SortField]>()
        let selectSorts = BehaviorRelay<NovelListModel.Novel.SortField>(value: .latest)
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
            .flatMap { extra.useCase.get() }
            .bind(to: state.model)
            .disposed(by: disposeBag)
        
        input.didTapSearchNovel
            .bind(onNext: { text in
                extra.wireframe.pushSearchResult(searchCondition: .text(text: text, sortField: state.selectSorts.value))
            })
            .disposed(by: disposeBag)
                
        input.didTapSearchableGenreView
            .bind(onNext: { genre in
                extra.wireframe.pushSearchResult(searchCondition: .genre(genre: genre.filters, sortField: state.selectSorts.value))
            })
            .disposed(by: disposeBag)
        
        input.didTapTagListView
            .bind(onNext: { tag in
                extra.wireframe.pushSearchResult(searchCondition: .tag(tag: [tag.name], sortField: state.selectSorts.value))
            })
            .disposed(by: disposeBag)
        
        input.didTapChangeSortFieldView
            .map { state.model.value?.sortField ?? [] }
            .bind(to: state.tapSortsView)
            .disposed(by: disposeBag)
        
        input.didSelectSortsField
            .bind(to: state.selectSorts)
            .disposed(by: disposeBag)
        
        return Output(
            model: state.model,
            tapSortsView: state.tapSortsView,
            didSelectSorts: state.selectSorts
        )
    }
}
