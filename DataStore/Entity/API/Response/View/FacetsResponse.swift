//
//  FacetsResponse.swift
//  DataStore
//
//  Created by ichikawa on 2020/10/28.
//

import Foundation

public struct FacetsResponse: Decodable {

    public let facets: Facets
}

extension FacetsResponse {
    
    public struct Facets: Decodable {
        public let tag: [String: Int]
        public let genre: [String: Int]
    }
}
