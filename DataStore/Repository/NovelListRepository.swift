//
//  NovelListRepository.swift
//  DataStore
//
//  Created by ichikawa on 2020/09/03.
//

import Foundation
import RxSwift

public enum NovelListRepositoryProvider {
    
    public static func provide() -> NovelListRepository {
        return NovelListRepositoryImpl(api: NovelListAPIDataStoreProvider.provide())
    }
}

public protocol NovelListRepository {
    func get(limit: Int, offset: Int) -> Single<NovelListResponse>
    func get(text: String, order: String) -> Single<NovelListResponse>
    func get(genre: String, order: String) -> Single<NovelListResponse>
}

private struct NovelListRepositoryImpl: NovelListRepository {

    private let api: NovelListAPIDataStore

    init(api: NovelListAPIDataStore) {
        self.api = api
    }
    
    func get(limit: Int, offset: Int) -> Single<NovelListResponse> {
        return api.get(limit: limit, offset: offset)
    }
    
    func get(text: String, order: String) -> Single<NovelListResponse> {
        return api.get(text: text, order: order)
    }
    
    func get(genre: String, order: String) -> Single<NovelListResponse> {
        return api.get(genre: genre, order: order)
    }
}
