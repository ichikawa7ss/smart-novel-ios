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
        self.text = ""
    }
    
    init(text: String) {
        self.limit = 20
        self.offset = 0
        self.text = text
    }
    
    let limit: Int
    
    let offset: Int
    
    let text: String
}
