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
    func getCandidateTags() -> Observable<[NovelListModel.Novel.Tag]>
    func getSortField() -> Observable<[NovelListModel.Novel.SortField]>
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
    
    func getCandidateTags() -> Observable<[NovelListModel.Novel.Tag]> {
        let tags: [NovelListModel.Novel.Tag] = [
            .init(name: "ファンタジー"),
            .init(name: "ラブコメ"),
            .init(name: "SF"),
            .init(name: "BL"),
            .init(name: "恋愛"),
            .init(name: "異世界ファンタジー"),
            .init(name: "現代ファンタジー"),
            .init(name: "歴史・時代"),
            .init(name: "エッセイ・ノンフィクション"),
        ]
        return .just(tags)
    }
    
    func getSortField() -> Observable<[NovelListModel.Novel.SortField]> {
        return .just(NovelListModel.Novel.SortField.allCases)
    }
}

