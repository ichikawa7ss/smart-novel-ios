//
//  RandomNovelListAPIDataStore.swift
//  DataStore
//
//  Created by ichikawa on 2020/10/26.
//

import APIKit
import RxSwift

enum RandomNovelListAPIDataStoreProvider {
    
    static func provide() -> RandomNovelListAPIDataStore {
        return RandomNovelListAPIDataStoreImpl()
    }
}

protocol RandomNovelListAPIDataStore {
    func get() -> Single<NovelListResponse>
}

private struct RandomNovelListAPIDataStoreImpl: RandomNovelListAPIDataStore {
    
    private let session: Session

    init(session: Session = .shared) {
        self.session = session
    }
    
    func get() -> Single<NovelListResponse> {
        return self.session.rx.response(for: RandomNovelListRequest())
    }
}
