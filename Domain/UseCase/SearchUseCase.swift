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
    func getCandidateGenres() -> Observable<[NovelListModel.Novel.SearchableGenre]>
    func getSortField() -> Observable<[NovelListModel.Novel.SortField]>
}

private struct SearchUseCaseImpl: SearchUseCase {

    func getCandidateGenres() -> Observable<[NovelListModel.Novel.SearchableGenre]> {
        return .just(NovelListModel.Novel.SearchableGenre.allCases)
    }
    
    func getSortField() -> Observable<[NovelListModel.Novel.SortField]> {
        return .just(NovelListModel.Novel.SortField.allCases)
    }
}

