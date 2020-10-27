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
        let didTapChangeSortFieldView  = PublishRelay<Void>()
        let didSelectSortsField = PublishRelay<NovelListModel.Novel.SortField>()
    }

    struct Output: OutputType {
        let genres: BehaviorRelay<[NovelListModel.Novel.SearchableGenre]>
        let tapSortsView: PublishRelay<[NovelListModel.Novel.SortField]>
        let didSelectSorts: BehaviorRelay<NovelListModel.Novel.SortField>
    }
    
    struct State: StateType {
        let genres = BehaviorRelay<[NovelListModel.Novel.SearchableGenre]>(value: [])
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
            .flatMap { extra.useCase.getCandidateGenres() }
            .bind(to: state.genres)
            .disposed(by: disposeBag)
        
        input.didTapSearchNovel
            .bind(onNext: { text in
                extra.wireframe.pushSearchResult(searchCondition: .text(text: text))
            })
            .disposed(by: disposeBag)
                
        input.didTapSearchableGenreView
            .bind(onNext: { genre in
                extra.wireframe.pushSearchResult(searchCondition: .genre(genre: genre.filters))
            })
            .disposed(by: disposeBag)
        
        input.didTapChangeSortFieldView
            .flatMap { extra.useCase.getSortField() }
            .bind(to: state.tapSortsView)
            .disposed(by: disposeBag)
        
        input.didSelectSortsField
            .bind(to: state.selectSorts)
            .disposed(by: disposeBag)
        
        return Output(
            genres: state.genres,
            tapSortsView: state.tapSortsView,
            didSelectSorts: state.selectSorts
        )
    }
}
