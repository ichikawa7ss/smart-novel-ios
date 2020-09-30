//
//  NovelListResponse.swift
//  DataStore
//
//  Created by ichikawa on 2020/09/29.
//

import Foundation

public struct NovelListResponse: Decodable {

    public let count: Int
    public let novels: [Result]

}

extension NovelListResponse {
    
    public struct Result: Decodable {
        
        public let title: String
        public let author: String
        public let url: String
        public let site: String
        public let genre: String
        public let tags: [Tag]
        public let updateTime: String
        
        private enum CodingKeys: String, CodingKey {
            case title
            case author
            case url
            case site = "site_name"
            case genre
            case tags = "tag"
            case updateTime = "updated_time"
        }
        
        public struct Tag: Decodable {
            public let name: String
        }
    }
}
