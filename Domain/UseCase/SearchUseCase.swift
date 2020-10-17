//
//  SearchUseCase.swift
//  Domain
//
//  Created by ichikawa on 2020/10/17.
//

import Foundation
import DataStore
import RxSwift

public enum SearchUseCaseProvider {
    
    public static func provide() -> SearchUseCase {
        return SearchUseCaseImpl(
            novelListRepository: NovelListRepositoryProvider.provide(),
            novelListTranslator: NovelListTranslatorProvider.provide()
        )
    }
}

public protocol SearchUseCase {
    func get(text: String) -> Single<NovelListModel>
}

private struct SearchUseCaseImpl: SearchUseCase {

    private let novelListRepository: NovelListRepository
    
    private let novelListTranslator: NovelListTranslator
    
    init(novelListRepository: NovelListRepository, novelListTranslator: NovelListTranslator) {
        self.novelListRepository = novelListRepository
        self.novelListTranslator = novelListTranslator
    }
    
    func get(text: String) -> Single<NovelListModel> {
        return self.novelListTranslator.convert(from: self.novelListRepository.get(text: text))
    }
}

