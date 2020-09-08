//
//  QiitaItemListResponse.swift
//  DataStore
//
//  Created by ichikawa on 2020/09/08.
//

import Foundation

public struct QiitaItemListResponse: Decodable {

    let items: [Item]

    struct Item: Decodable {
        let title: String
        let likesCount: Int
        let user: User
        
        private enum CodingKeys: String, CodingKey {
            case title
            case likesCount = "likes_count"
            case user
        }
        
        struct User: Decodable {
            let id: String
        }
    }
}

extension QiitaItemListResponse {

    // ルートが配列のレスポンスをデコードする
    public init(from decoder: Decoder) throws {
        var items: [Item] = []
        var unkeyedContainer = try decoder.unkeyedContainer()
        while !unkeyedContainer.isAtEnd {
            let user = try unkeyedContainer.decode(Item.self)
            items.append(user)
        }
        self.init(items: items)
    }
}
