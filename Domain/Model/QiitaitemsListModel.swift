//
//  QiitaitemsListModel.swift
//  Domain
//
//  Created by ichikawa on 2020/09/29.
//

import Foundation
import DataStore

public struct QiitaItemsListModel{

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
