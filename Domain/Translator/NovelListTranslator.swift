//
//  NovelListTranslator.swift
//  Domain
//
//  Created by ichikawa on 2020/09/03.
//

import Foundation
import DataStore
import RxSwift

enum NovelListTranslatorProvider {
    
    static func provide() -> NovelListTranslator {
        return NovelListTranslatorImpl()
    }
}

protocol NovelListTranslator {
    func convert(from response: Single<NovelListResponse>) -> Single<NovelListModel>
}

private struct NovelListTranslatorImpl: NovelListTranslator {

    func convert(from response: Single<NovelListResponse>) -> Single<NovelListModel> {
        return response.map { NovelListModel($0)}
    }
}

