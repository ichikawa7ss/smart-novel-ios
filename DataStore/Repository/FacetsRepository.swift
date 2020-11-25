//
//  FacetsRepository.swift
//  DataStore
//
//  Created by ichikawa on 2020/10/28.
//

import Foundation
import RxSwift

public enum FacetsRepositoryProvider {
    
    public static func provide() -> FacetsRepository {
        return FacetsRepositoryImpl(api: FacetsAPIDataStoreProvider.provide())
    }
}

public protocol FacetsRepository {
    func get() -> Single<FacetsResponse>
}

private struct FacetsRepositoryImpl: FacetsRepository {

    private let api: FacetsAPIDataStore

    init(api: FacetsAPIDataStore) {
        self.api = api
    }
    
    func get() -> Single<FacetsResponse> {
        return api.get()
    }
}
