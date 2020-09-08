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
    func get() -> Single<NovelListResponse>
}

private struct NovelListRepositoryImpl: NovelListRepository {

    private let api: NovelListAPIDataStore

    init(api: NovelListAPIDataStore) {
        self.api = api
    }
    
    func get() -> Single<NovelListResponse> {
        return api.get()
    }
}

public protocol NovelListResponse{}

struct NovelListResponseImpl: NovelListResponse {}
