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
    func get(limit: Int, offset: Int) -> Single<NovelListResponse>
    func get(text: String, order: String, limit: Int, offset: Int) -> Single<NovelListResponse>
    func get(genres: [String], order: String, limit: Int, offset: Int) -> Single<NovelListResponse>
}

private struct NovelListAPIDataStoreImpl: NovelListAPIDataStore {
    
    private let session: Session

    init(session: Session = .shared) {
        self.session = session
    }
    
    func get(limit: Int, offset: Int) -> Single<NovelListResponse> {
        return self.session.rx.response(for: NovelListRequest(limit: limit, offset: offset))
    }
    
    func get(text: String, order: String, limit: Int, offset: Int) -> Single<NovelListResponse> {
        return self.session.rx.response(for: NovelListRequest(text: text, order: order, limit: limit, offset: offset))
    }
    
    func get(genres: [String], order: String, limit: Int, offset: Int) -> Single<NovelListResponse> {
        return self.session.rx.response(for: NovelListRequest(genres: genres, order: order, limit: limit, offset: offset))
    }
}
