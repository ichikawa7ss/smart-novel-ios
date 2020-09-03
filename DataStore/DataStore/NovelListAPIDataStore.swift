//
//  NovelListAPIDataStore.swift
//  DataStore
//
//  Created by ichikawa on 2020/09/03.
//

import APIKit
import RxSwift

enum NovelListAPIDataStoreProvider {
    
    static func provide() -> NovelListAPIDataStore {
        return NovelListAPIDataStoreImpl()
    }
}

protocol NovelListAPIDataStore {
    func get() -> Single<NovelListResponse>
}

private struct NovelListAPIDataStoreImpl: NovelListAPIDataStore {
    
    private let session: Session

    init(session: Session = .shared) {
        self.session = session
    }
    
    func get() -> Single<NovelListResponse> {
        return .just(NovelListResponseImpl())
//        return self.session
    }
}
