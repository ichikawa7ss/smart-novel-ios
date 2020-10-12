//
//  NovelListNovelListViewModel.swift
//  smart-novel-ios
//
//  Created by ichikawa7ss on 24/08/2020.
//  Copyright © 2020 Shoma Ichikawa. All rights reserved.
//

import Action
import RxCocoa
import RxSwift
import Unio
import Domain

protocol NovelListViewModelType: AnyObject {
    var input: InputWrapper<NovelListViewModel.Input> { get }
    var output: OutputWrapper<NovelListViewModel.Output> { get }
}

final class NovelListViewModel: UnioStream<NovelListViewModel>, NovelListViewModelType  {
    
    init(extra: Extra) {
        super.init(input: Input(),
                   state: State(),
                   extra: extra)
    }
}

extension NovelListViewModel {
    
    struct Input: InputType {
        let viewWillAppear = PublishRelay<Void>()
        let reachedBottom = PublishRelay<Void>()
        let tapNovelListCell = PublishRelay<NovelListModel.Novel>()
    }
    
    struct Output: OutputType {
        let novels: BehaviorRelay<[NovelListModel.Novel]>
    }
    
    struct State: StateType {
        let novels = BehaviorRelay<[NovelListModel.Novel]>(value: [])
    }
    
    struct Extra: ExtraType {
        let wireframe: NovelListWireframe
        let useCase: NovelListUseCase
    }
}

extension NovelListViewModel {

    static func bind(from dependency: Dependency<Input, State, Extra>, disposeBag: DisposeBag) -> Output {
        let input = dependency.inputObservables
        let state = dependency.state
        let extra = dependency.extra
        
        let fetchData = Action<(limit: Int, offset: Int), NovelListModel> { args in
            extra.useCase.get(limit: args.limit, offset: args.offset)
        }
        
        Observable.merge (
            input.viewWillAppear,
            input.reachedBottom
        )
            .bind(onNext: {
                fetchData.execute((limit: 20, offset: state.novels.value.count))
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
        
        input.tapNovelListCell
            .map { $0.novelDetailUrl } // FIXME: できればURLのチェック機構を入れたい
            .filterNil()
            .bind(onNext:  { url in
                extra.wireframe.pushNovelDetailWeb(url: url)
            })
            .disposed(by: disposeBag)
        
        return Output(
            novels: state.novels
        )
    }
}
