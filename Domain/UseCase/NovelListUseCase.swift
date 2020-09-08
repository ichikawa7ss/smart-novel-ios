//
//  NovelListUseCase.swift
//  Domain
//
//  Created by ichikawa on 2020/09/01.
//

import Foundation
import DataStore
import RxSwift

public enum NovelListUseCaseProvider {
    
    public static func provide() -> NovelListUseCase {
        return NovelListUseCaseImpl(
            novelListRepository: NovelListRepositoryProvider.provide(),
            novelListTranslator: NovelListTranslatorProvider.provide()
        )
    }
}

public protocol NovelListUseCase {
    func get() -> Single<NovelListModel>
}

private struct NovelListUseCaseImpl: NovelListUseCase {

    private let novelListRepository: NovelListRepository
    
    private let novelListTranslator: NovelListTranslator
    
    init(novelListRepository: NovelListRepository, novelListTranslator: NovelListTranslator) {
        self.novelListRepository = novelListRepository
        self.novelListTranslator = novelListTranslator
    }
    
    func get() -> Single<NovelListModel> {
        return self.novelListTranslator.convert(from: self.novelListRepository.get())
    }
}

