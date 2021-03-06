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
        let reachedBottom = PublishRelay<Void>()
        let tapNovelListCell = PublishRelay<NovelListModel.Novel>()
        let didTapChangeSortFieldView  = PublishRelay<Void>()
        let didSelectSortsField = PublishRelay<NovelListModel.Novel.SortField>()
    }

    struct Output: OutputType {
        let novels: BehaviorRelay<[NovelListModel.Novel]>
        let tapSortsView: PublishRelay<[NovelListModel.Novel.SortField]>
        let networkState: PublishRelay<NetworkState>
        let error: Observable<Error>
    }
    
    struct State: StateType {
        let novels = BehaviorRelay<[NovelListModel.Novel]>(value: [])
        let tapSortsView = PublishRelay<[NovelListModel.Novel.SortField]>()
        let selectSorts = BehaviorRelay<NovelListModel.Novel.SortField>(value: .latest)
        let networkState = PublishRelay<NetworkState>()
    }

    struct Extra: ExtraType {
        let wireframe: SearchResultWireframe
        let useCase: SearchResultUseCase
        let searchCondition: SearchTransitType
    }
}

extension SearchResultViewModel {

    static func bind(from dependency: Dependency<Input, State, Extra>, disposeBag: DisposeBag) -> Output {
        let input = dependency.inputObservables
        let state = dependency.state
        let extra = dependency.extra
        
        let fetchDataWithWord = Action<(text: String, order: NovelListModel.Novel.SortField, limit: Int, offset: Int), NovelListModel> { args in
            extra.useCase.get(text: args.text, order: args.order, limit: args.limit, offset: args.offset)
        }
        
        let fetchSpecificGenre = Action<(genres: [String], order: NovelListModel.Novel.SortField, limit: Int, offset: Int), NovelListModel> { args in
            extra.useCase.get(genres: args.genres, order: args.order, limit: args.limit, offset: args.offset)
        }
        
        let fetchSpecificTag = Action<(tags: [String], order: NovelListModel.Novel.SortField, limit: Int, offset: Int), NovelListModel> { args in
            extra.useCase.get(tags: args.tags, order: args.order, limit: args.limit, offset: args.offset)
        }
        
        Observable.merge(
            input.viewWillAppear,
            input.reachedBottom
        )
            .flatMap { state.selectSorts }
            .bind(onNext: { sortFiled in
                switch extra.searchCondition {
                case .text(text: let text, sortField: let sort):
                    fetchDataWithWord.execute((text: text, order: sort, limit: 20, offset: state.novels.value.count))
                case .genre(genre: let genres, sortField: let sort):
                    fetchSpecificGenre.execute((genres: genres, order: sort, limit: 20, offset: state.novels.value.count))
                case .tag(tag: let tags, sortField: let sort):
                    fetchSpecificTag.execute((tags: tags, order: sort, limit: 20, offset: state.novels.value.count))
                }
            })
            .disposed(by: disposeBag)
        
        Observable.merge(
            fetchDataWithWord.elements,
            fetchSpecificGenre.elements,
            fetchSpecificTag.elements
        )
            .flatMap { model -> BehaviorRelay<[NovelListModel.Novel]> in
                var retNovels = state.novels.value
                retNovels += model.novels
                return BehaviorRelay(value: retNovels)
            }
            .bind(to: state.novels)
            .disposed(by: disposeBag)
        
        Observable.merge(
            fetchDataWithWord.state,
            fetchSpecificGenre.state,
            fetchSpecificTag.state
        )
            .bind(to: state.networkState)
            .disposed(by: disposeBag)

        
        input.tapNovelListCell
            .map { $0.novelDetailUrl } // FIXME: できればURLのチェック機構を入れたい
            .filterNil()
            .bind(onNext:  { url in
                extra.wireframe.pushNovelDetailWeb(url: url)
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
        
        let error = Observable.merge(
            fetchSpecificTag.underlyingError,
            fetchDataWithWord.underlyingError,
            fetchSpecificGenre.underlyingError
        )
        
        return Output(
            novels: state.novels,
            tapSortsView: state.tapSortsView,
            networkState: state.networkState,
            error: error
        )
    }
}
