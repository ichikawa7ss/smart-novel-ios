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
        return .get
    }
    
    var path: String {
        return ""
    }
}
