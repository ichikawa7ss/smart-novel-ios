//
//  NovelListRequest.swift
//  DataStore
//
//  Created by ichikawa on 2020/09/29.
//


import APIKit

struct NovelListRequest: APIRequestable {

    typealias Response = NovelListResponse
    
    var method: HTTPMethod {
        return .post // APIの仕様でデフォルトパラメータ以外で取得する場合はPOST
    }
    
    var path: String {
        return "/search-novel"
    }
    
    init(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
        self.searchText = ""
        self.filters = [:]
        self.order = "latest"
    }
    
    init(text: String, order: String, limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
        self.searchText = text
        self.filters = [:]
        self.order = order
    }
    
    init(genres: [String], order: String, limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
        self.searchText = ""
        self.filters = ["genre": genres]
        self.order = order
    }

    init(tags: [String], order: String, limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
        self.searchText = ""
        self.filters = ["tag": tags]
        self.order = order
    }

    
    let limit: Int
    
    let offset: Int
    
    let searchText: String
    
    let filters: [String: [String]]
    
    let order: String
}
