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
        return SearchUseCaseImpl()
    }
}

public protocol SearchUseCase {
    func getCandidateTags() -> Observable<[NovelListModel.Novel.Tag]>
    func getSortField() -> Observable<[NovelListModel.Novel.SortField]>
}

private struct SearchUseCaseImpl: SearchUseCase {

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

