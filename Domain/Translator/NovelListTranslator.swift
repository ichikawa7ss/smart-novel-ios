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
    func convert(from response: Single<QiitaItemListResponse>) -> Single<NovelListModel>
}

private struct NovelListTranslatorImpl: NovelListTranslator {

    func convert(from response: Single<QiitaItemListResponse>) -> Single<NovelListModel> {
        return response.map { NovelListModel($0)}
    }
}

public struct NovelListModel{

    public let items: [Item]
    
    init(_ response: QiitaItemListResponse) {
        self.items = response.items.map {Item(item: $0)}
    }
    
    public struct Item {

        public let title: String
        public let likesCount: Int
        public let userName: String
        
        init(item: QiitaItemListResponse.Item) {
            self.title = item.title
            self.likesCount = item.likesCount
            self.userName = item.user.id
        }
    }
}
