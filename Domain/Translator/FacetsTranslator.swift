//
//  FacetsTranslator.swift
//  Domain
//
//  Created by ichikawa on 2020/10/28.
//

import Foundation
import DataStore
import RxSwift

enum FacetsTranslatorProvider {
    
    static func provide() -> FacetsTranslator {
        return FacetsTranslatorImpl()
    }
}

protocol FacetsTranslator {
    func convert(from response: Single<FacetsResponse>) -> Single<FacetsModel>
}

private struct FacetsTranslatorImpl: FacetsTranslator {

    func convert(from response: Single<FacetsResponse>) -> Single<FacetsModel> {
        return response.map { FacetsModel($0)}
    }
}

