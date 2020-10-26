//
//  HomeUseCase.swift
//  Domain
//
//  Created by ichikawa on 2020/09/01.
//

import Foundation
import DataStore
import RxSwift

public enum HomeUseCaseProvider {
    
    public static func provide() -> HomeUseCase {
        return HomeUseCaseImpl(
            randomNovelListRepository: RandomNovelListRepositoryProvider.provide(),
            novelListTranslator: NovelListTranslatorProvider.provide()
        )
    }
}

public protocol HomeUseCase {
    func get() -> Single<NovelListModel>
}

private struct HomeUseCaseImpl: HomeUseCase {

    private let randomNovelListRepository: RandomNovelListRepository
    
    private let novelListTranslator: NovelListTranslator
    
    init(randomNovelListRepository: RandomNovelListRepository, novelListTranslator: NovelListTranslator) {
        self.randomNovelListRepository = randomNovelListRepository
        self.novelListTranslator = novelListTranslator
    }
    
    func get() -> Single<NovelListModel> {
        return self.novelListTranslator.convert(from: self.randomNovelListRepository.get())
    }
}

