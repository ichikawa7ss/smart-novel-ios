//
//  RandomNovelListRepository.swift
//  DataStore
//
//  Created by ichikawa on 2020/10/26.
//

import Foundation
import RxSwift

public enum RandomNovelListRepositoryProvider {
    
    public static func provide() -> RandomNovelListRepository {
        return RandomNovelListRepositoryImpl(api: RandomNovelListAPIDataStoreProvider.provide())
    }
}

public protocol RandomNovelListRepository {
    func get() -> Single<NovelListResponse>
}

private struct RandomNovelListRepositoryImpl: RandomNovelListRepository {

    private let api: RandomNovelListAPIDataStore

    init(api: RandomNovelListAPIDataStore) {
        self.api = api
    }
    
    func get() -> Single<NovelListResponse> {
        return api.get()
    }
}
