//
//  FacetsRequest.swift
//  DataStore
//
//  Created by ichikawa on 2020/10/28.
//

import APIKit

struct FacetsRequest: APIRequestable {

    typealias Response = FacetsResponse
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/search-novel"
    }
}
