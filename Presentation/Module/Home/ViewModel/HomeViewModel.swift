//
//  HomeViewModel.swift
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

protocol HomeViewModelType: AnyObject {
    var input: InputWrapper<HomeViewModel.Input> { get }
    var output: OutputWrapper<HomeViewModel.Output> { get }
}

final class HomeViewModel: UnioStream<HomeViewModel>, HomeViewModelType  {
    
    init(extra: Extra) {
        super.init(input: Input(),
                   state: State(),
                   extra: extra)
    }
}

extension HomeViewModel {
    
    struct Input: InputType {
        let viewWillAppear = PublishRelay<Void>()
        let reachedBottom = PublishRelay<Void>()
        let tapNovelListCell = PublishRelay<NovelListModel.Novel>()
    }
    
    struct Output: OutputType {
        let novels: BehaviorRelay<[NovelListModel.Novel]>
        let networkState: PublishRelay<NetworkState>
        let error: Observable<Error>
    }
    
    struct State: StateType {
        let novels = BehaviorRelay<[NovelListModel.Novel]>(value: [])
        let networkState = PublishRelay<NetworkState>()
    }
    
    struct Extra: ExtraType {
        let wireframe: HomeWireframe
        let useCase: HomeUseCase
    }
}

extension HomeViewModel {

    static func bind(from dependency: Dependency<Input, State, Extra>, disposeBag: DisposeBag) -> Output {
        let input = dependency.inputObservables
        let state = dependency.state
        let extra = dependency.extra
        
        let fetchData = Action<Void, NovelListModel> { args in
            extra.useCase.get()
        }
        
        Observable.merge (
            input.viewWillAppear,
            input.reachedBottom
        )
            .bind(onNext: {
                fetchData.execute()
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
        
        fetchData.state
            .take(1) // 初回は遅延を入れる
            .delay(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(to: state.networkState)
            .disposed(by: disposeBag)

        fetchData.state
            .skip(1) // 2回目移行は普通に出す
            .bind(to: state.networkState)
            .disposed(by: disposeBag)
        
        
        return Output(
            novels: state.novels,
            networkState: state.networkState,
            error: fetchData.underlyingError
        )
    }
}
