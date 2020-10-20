//
//  SearchResultUseCase.swift
//  Domain
//
//  Created by ichikawa on 2020/10/19.
//

import Foundation
import DataStore
import RxSwift

public enum SearchResultUseCaseProvider {
    
    public static func provide() -> SearchResultUseCase {
        return SearchResultUseCaseImpl(
            novelListRepository: NovelListRepositoryProvider.provide(),
            novelListTranslator: NovelListTranslatorProvider.provide()
        )
    }
}

public protocol SearchResultUseCase {
    func get(text: String, order: NovelListModel.Novel.SortField, limit: Int, offset: Int) -> Single<NovelListModel>
    func get(genre: String, order: NovelListModel.Novel.SortField, limit: Int, offset: Int) -> Single<NovelListModel>
    func getSortField() -> Observable<[NovelListModel.Novel.SortField]>
}

private struct SearchResultUseCaseImpl: SearchResultUseCase {

    private let novelListRepository: NovelListRepository
    
    private let novelListTranslator: NovelListTranslator
    
    init(novelListRepository: NovelListRepository, novelListTranslator: NovelListTranslator) {
        self.novelListRepository = novelListRepository
        self.novelListTranslator = novelListTranslator
    }
    
    func get(text: String, order: NovelListModel.Novel.SortField, limit: Int, offset: Int) -> Single<NovelListModel> {
        return self.novelListTranslator.convert(from: self.novelListRepository.get(text: text, order: order.rawValue, limit: limit, offset: offset))
    }
    
    func get(genre: String, order: NovelListModel.Novel.SortField, limit: Int, offset: Int) -> Single<NovelListModel> {
        return self.novelListTranslator.convert(from: self.novelListRepository.get(genre: genre, order: order.rawValue, limit: limit, offset: offset))
    }

    func getSortField() -> Observable<[NovelListModel.Novel.SortField]> {
        return .just(NovelListModel.Novel.SortField.allCases)
    }
}

