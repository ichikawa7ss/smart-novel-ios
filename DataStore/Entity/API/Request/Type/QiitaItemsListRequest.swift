//
//  QiitaItemsListRequest.swift
//  DataStore
//
//  Created by ichikawa on 2020/09/08.
//

import APIKit

struct QiitaItemsListRequest: APIRequestable {

    typealias Response = QiitaItemListResponse
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/items"
    }
    
    let page: Int = 1
    
    let perPage: Int = 20
    
    let query: String = "tag:Swift"
}
