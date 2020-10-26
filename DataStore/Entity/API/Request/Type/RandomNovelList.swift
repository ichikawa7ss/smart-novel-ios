//
//  RandomNovelList.swift
//  DataStore
//
//  Created by ichikawa on 2020/10/26.
//

import APIKit

struct RandomNovelListRequest: APIRequestable {

    typealias Response = NovelListResponse
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/smart-novel-random"
    }    
}
