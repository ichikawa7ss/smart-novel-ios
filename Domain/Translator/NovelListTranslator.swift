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
        return .just(NovelListModelImpl(response))
    }
}

protocol NovelListModel{}

private struct NovelListModelImpl: NovelListModel {
    
    let text: String
    
    init(_ model: Single<NovelListResponse>) {
        self.text = "test"
    }
}
