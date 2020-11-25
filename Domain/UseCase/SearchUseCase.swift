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
    func get() -> Observable<SearchModel>
}

private struct SearchUseCaseImpl: SearchUseCase {

    func get() -> Observable<SearchModel> {
        let genres = self.getCandidateGenres()
        let tags = self.getPopularTag()
        let sortFields = self.getSortField()
        return .just(SearchModel(popularTags: tags, genres: genres, sortField: sortFields))
    }
    
    private func getCandidateGenres() -> [NovelListModel.Novel.SearchableGenre] {
        return NovelListModel.Novel.SearchableGenre.allCases
    }
    
    private func getSortField() -> [NovelListModel.Novel.SortField] {
        return NovelListModel.Novel.SortField.allCases
    }
    
    private func getPopularTag() -> [NovelListModel.Novel.Tag] {
        return SmartNovelDomain.shared.popularTags
    }
}

