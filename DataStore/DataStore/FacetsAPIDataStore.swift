//
//  FacetsAPIDataStore.swift
//  DataStore
//
//  Created by ichikawa on 2020/10/28.
//

import APIKit
import RxSwift

enum FacetsAPIDataStoreProvider {
    
    static func provide() -> FacetsAPIDataStore {
        return FacetsAPIDataStoreImpl()
    }
}

protocol FacetsAPIDataStore {
    func get() -> Single<FacetsResponse>
}

private struct FacetsAPIDataStoreImpl: FacetsAPIDataStore {
    
    private let session: Session

    init(session: Session = .shared) {
        self.session = session
    }
    
    func get() -> Single<FacetsResponse> {
        return self.session.rx.response(for: FacetsRequest())
    }
}
