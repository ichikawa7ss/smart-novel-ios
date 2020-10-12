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
    
    let limit: Int
    
    let offset: Int
}
