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
            novelListRepository: NovelListRepositoryProvider.provide(),
            novelListTranslator: NovelListTranslatorProvider.provide()
        )
    }
}

public protocol HomeUseCase {
    func get(limit: Int, offset: Int) -> Single<NovelListModel>
}

private struct HomeUseCaseImpl: HomeUseCase {

    private let novelListRepository: NovelListRepository
    
    private let novelListTranslator: NovelListTranslator
    
    init(novelListRepository: NovelListRepository, novelListTranslator: NovelListTranslator) {
        self.novelListRepository = novelListRepository
        self.novelListTranslator = novelListTranslator
    }
    
    func get(limit: Int, offset: Int) -> Single<NovelListModel> {
        return self.novelListTranslator.convert(from: self.novelListRepository.get(limit: limit, offset: offset))
    }
}

